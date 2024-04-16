const { promisify } = require("util");
const User = require("../models/userModel");
const catchAsync = require("../utils/catchAsync");
const jwt = require("jsonwebtoken");
const AppError = require("../utils/appError");
const sendEmail = require("../utils/email");
//-----------------------------------------
const signToken = function (id) {
  return jwt.sign({ id }, process.env.JWT_SECRET, {
    expiresIn: process.env.JWT_EXPIRE_IN,
  });
};

const generateRefreshToken = (userId) => {
  const refreshToken = jwt.sign(
    { id: userId },
    process.env.REFRESH_TOKEN_SECRET,
    {
      expiresIn: process.env.REFRESH_TOKEN_EXPIRE_IN,
    }
  );
  return refreshToken;
};
//---------------------------------------------
createSendToken = (user, statuscode, res) => {
  const token = signToken(user._id);
  const refreshToken = generateRefreshToken(user._id);
  if (process.env.NODE_ENV === "production") cookieOptions.secure = true;
  res.cookie("jwt", token, { maxAge: 2 * 60 * 60 * 1000, httpOnly: true });
  res.status(statuscode).json({
    status: "success",
    token,
    refreshToken,
    data: { user },
  });
};
//-----------------------------------------

//----------- Sign Up ---------------------

exports.signUp = catchAsync(async (req, res, next) => {
  let newAccount = null;
  console.log(req.body);
  if (
    !req.body.email ||
    !req.body.password ||
    !req.body.passwordConfirm ||
    !req.body.firstName ||
    !req.body.lastName
  ) {
    return next(
      new AppError(
        "Veuillez saisir votre e-mail, mot de passe, prénom et nom !",
        400
      )
    );
  }

  newAccount = await User.findOne({ email: req.body.email });
  if (newAccount) {
    return next(new AppError("Cet e-mail est déjà utilisé !", 400));
  }
  if (req.file) req.body.profilePicture = req.file.filename;
  newAccount = await User.create({
    profilePicture: req.body.profilePicture,
    email: req.body.email,
    phoneNumber: req.body.phoneNumber,
    password: req.body.password,
    passwordConfirm: req.body.passwordConfirm,
    firstName: req.body.firstName,
    lastName: req.body.lastName,
  });

  const activeToken = newAccount.createActiveUserToken();
  newAccount.activeAccountToken = activeToken;
  newAccount.activeAccountTokenExpires = Date.now() + 1000 * 60 * 60 * 1000;
  newAccount.save({ validateBeforeSave: false });

  const activeURL = `http://localhost:3000/api/v1/users/accountActivation/${activeToken}`;
  const message = `Bonjour,\n
  Merci de créer un compte a notre platform.\n
  Pour activer votre compte accéder le lien suivant:\n ${activeURL}`;
  try {
    await sendEmail({
      email: newAccount.email,
      subject: "Activation de compte",
      message,
    });
    res.status(201).json({
      status: "success",
      message: "Votre e-mail d'activation a été envoyé avec succès ",
    });
  } catch (err) {
    console.log(err);
    // newAccount.activeAccountToken = undefined;
    // newAccount.activeAccountTokenExpires = undefined;
    // newAccount.save({ validateBeforeSave: false });
    return next(
      new AppError(
        "Une erreur s'est produite lors de l'envoi de l'e-mail ! Merci d'essayer plus tard .",
        500
      )
    );
  }
});

// ----------------------- Activate Account ---------------------

exports.activeAccount = catchAsync(async (req, res, next) => {
  let token = req.params.token;
  let user = await User.findOne({
    activeAccountToken: token,
  });
  if (!user) {
    return next(new AppError("Le jeton n'est pas valide !", 401));
  }
  if (Date.now() > user.activeAccountTokenExpires) {
    await User.findOneAndDelete({ activeAccountToken: token });
    return next(
      new AppError(
        "Votre jeton d'activation n'est plus valide, veuillez vous réinscrire !"
      )
    );
  }
  user.accountStatus = true;
  user.activeAccountToken = undefined;
  user.activeAccountTokenExpires = undefined;
  await user.save({ validateBeforeSave: false });
  createSendToken(user, 201, res);
});

//-----------------------------------------

exports.login = catchAsync(async (req, res, next) => {
  const { email, password } = req.body;
  if (!email || !password) {
    return next(
      new AppError("Veuillez fournir votre email et mot de passe", 400)
    );
  }
  const user = await User.findOne({ email }).select("+password");
  if (!user) {
    return next(new AppError("Email ou mot de passe incorrect", 400));
  }
  if (user && !(await user.correctPassword(password, user.password))) {
    return next(new AppError("Email ou mot de passe incorrect", 400));
  }
  if (
    user.accountStatus == false &&
    user.activeAccountTokenExpires > Date.now()
  ) {
    return next(
      new AppError(
        "Votre compte n'est pas encore activé !activer votre comptre pour login",
        401
      )
    );
  }
  if (!user.accountStatus && user.activeAccountTokenExpires < Date.now()) {
    await User.findByIdAndDelete({ _id: user._id });
    return next(
      new AppError(
        "Vous n'avez pas activez votre compte et le code est invalide maintenant . Vous devez inscrire à nouveau !",
        401
      )
    );
  }

  createSendToken(user, 200, res);
});
//-----------------------------------------
exports.protect = catchAsync(async (req, res, next) => {
  // 1) verify if the user is loged in :
  let token;

  if (
    req.headers.authorization &&
    req.headers.authorization.startsWith("Bearer")
  ) {
    token = req.headers.authorization.split(" ")[1];
  }
  //token = req.headers.authorization.split(" ")[1];
  if (!token) {
    return next(
      new AppError(
        "Vous n'êtes pas connecté ! Veuillez vous connecter pour accéder à cette route.",
        410
      )
    );
  }
  // 2) vérifier si le token est valide ou non :
  let decoded;
  try {
    decoded = await promisify(jwt.verify)(token, process.env.JWT_SECRET);
  } catch (err) {
    if (err instanceof jwt.TokenExpiredError) {
      return next(
        new AppError("Votre session a expiré! Veuillez vous reconnecter.", 410)
      );
    } else {
      return next(
        new AppError("Erreur lors de la vérification du token.", 410)
      );
    }
  }
  // 3) vérifier si l'utilisateur existe toujours dans la base de données ou non :
  const currentUser = await User.findById(decoded.id);
  if (!currentUser) {
    return next(new AppError("L'utilisateur n'existe plus!", 410));
  }
  req.user = currentUser;




  next();
});

//---------------------------  Forgot Password -----------------------------
exports.forgotPassword = catchAsync(async (req, res, next) => {
  // 1 - get the email from the client and verify if it exist or not
  const email = req.body.email;
  const account = await User.findOne({ email });
  if (!account) {
    return next(
      new AppError("Il n'y a pas d'utilisateur avec cette adresse e-mail", 400)
    );
  }
  // 2 - generate a token with which the password is gonna reset :
  const resetCode = account.createPasswordResetCode();
  account.save({ validateBeforeSave: false });
  // 3 - send the token to the client to use it and reset his password :
  const message = `Bonjour,\n
  Vous avez oublié votre mot de passe ?\n
  Voici votre code de reinitialization : \n    ${resetCode}
   `;
  try {
    await sendEmail({
      email: account.email,
      subject: "Code de réinitialisation de mot de passe (Valable 30 minutes) ",
      message,
    });
    res.status(200).json({
      status: "success",
      message:
        "Votre code de réinitialisation de l'e-mail a été envoyé avec succès ",
    });
  } catch (err) {
    account.passwordResetExpires = undefined;
    account.passwordResetCode = undefined;
    account.save({ validateBeforeSave: false });
    return next(
      new AppError(
        "Une erreur s'est produite lors de l'envoi de l'e-mail ! Merci d'essayer plus tard .",
        500
      )
    );
  }
});
//------------------------------------
exports.resetPasswordStepOne = catchAsync(async (req, res, next) => {
  //verify if the token passed in the URL is valid and correct or no :
  const account = await User.findOne({
    passwordResetCode: req.body.passwordResetCode,
    passwordResetExpires: { $gt: Date.now() },
  });

  if (!account) {
    return next(new AppError("Le Code est invalide ou a expiré !! ", 400));
  }

  res.status(200).json({
    status: "success",
  });
});
//----------------------------------------
exports.resetPasswordStepTwo = catchAsync(async (req, res, next) => {
  const account = await User.findOne({
    passwordResetCode: req.body.passwordResetCode,
  });

  if (!account) {
    return next(new AppError("Le Code est invalide ou a expiré !! ", 400));
  }
  if (
    req.body.password === null ||
    req.body.passwordConfirm === null ||
    req.body.password === "" ||
    req.body.passwordConfirm === ""
  ) {
    return next(
      new AppError(
        "Veuillez saisir votre mot de passe et confirmer votre mot de passe !"
      ),
      400
    );
  }

  if (req.body.password !== req.body.passwordConfirm) {
    return next(
      new AppError(
        "Les mots de passe ne correspondent pas ! veuillez saisir les mêmes mots de passe !",
        400
      )
    );
  }

  account.password = req.body.password;
  account.passwordConfirm = req.body.passwordConfirm;
  account.passwordResetCode = undefined;
  account.passwordResetExpires = undefined;
  account.save({ validateBeforeSave: false });
  // -- Modify the passwordModifyAt propertie
  // loged the user In :
  createSendToken(account, 200, res);
});
//------------------------------------
exports.updateUserPassword = catchAsync(async (req, res, next) => {
  const account = await User.findOne({
    _id: req.user.id,
  }).select("+password");
  if (
    !(await account.correctPassword(req.body.oldPassword, account.password))
  ) {
    return next(
      new AppError(
        "vous devez entrer votre ancien mot de passe correctement !! ",
        400
      )
    );
  }

  if (await account.correctPassword(req.body.newPassword, account.password)) {
    return next(
      new AppError(
        "Saisir une autre mot de passe differnt de votre ancien mot de passe ! ",
        400
      )
    );
  }

  if ((await req.body.newPassword) !== req.body.newPasswordConfirm) {
    return next(
      new AppError(
        "Les mots de passe ne correspondent pas ! veuillez confirmer votre mot de passe !",
        400
      )
    );
  }

  account.password = req.body.newPassword;
  account.passwordConfirm = req.body.newPasswordConfirm;
  await account.save();
  try {
    await sendEmail({
      email: account.email,
      subject: "mot de passe modifié",
      message: "Votre mot de passe est modifié ",
    });

    createSendToken(account, 200, res);
  } catch (err) {
    console.log(err.message);
  }
});

exports.refreshToken = catchAsync(async (req, res, next) => {
  const { refreshToken } = req.body;
  if (!refreshToken) {
    return next(new AppError("Aucun jeton de rafraîchissement fourni", 400));
  }

  const decoded = jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET);
  const user = await User.findById(decoded.id);

  if (!user) {
    return next(new AppError("Jeton de rafraîchissement invalide", 401));
  }

  const newAccessToken = signToken(user._id);
  const newRefreshToken = generateRefreshToken(user._id);

  res.status(200).json({
    status: "success",
    accessToken: newAccessToken,
    refreshToken: newRefreshToken,
  });
});
