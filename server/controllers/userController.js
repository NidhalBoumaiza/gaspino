const User = require("../models/userModel");
const catchAsync = require("./../utils/catchAsync");
const AppError = require("../utils/appError");
const { findById, findByIdAndUpdate } = require("../models/userModel");
const {
  deleteImageProductFromFolder,
} = require("../utils/deleteImageFromFolder");
const filtredObj = (obj, ...allowedFields) => {
  const newObj = {};
  Object.keys(obj).forEach((el) => {
    if (allowedFields.includes(el)) newObj[el] = obj[el];
  });
  return newObj;
};

//-----------------------Update Me -----------------------------------
exports.updateMe = catchAsync(async (req, res, next) => {
  const user = await User.findById(req.user.id);
  if (!user) {
    return next(new AppError("Aucun utilisateur trouvé", 400));
  }

  const filtredBody = filtredObj(
    req.body,
    "firstName",
    "lastName",
    "phoneNumber",
    "profilePicture"
  );

  if (req.file) {
    filtredBody.profilePicture = req.file.filename;
  }

  const imagestoDelete = [];
  if (user.profilePicture && filtredBody.profilePicture && user.profilePicture !== filtredBody.profilePicture) {
    imagestoDelete.push(user.profilePicture);
  }

  deleteImageProductFromFolder(imagestoDelete);

  const updatedUser = await User.findByIdAndUpdate(
    req.user.id,
    filtredBody,
    {
      new: true,
      runValidators: true,
    }
  );

  res.status(200).json({
    status: "Update",
    user: updatedUser,
  });
});


//*********************************************************************** */ */
//----------------------------disable my account ----------------------------------
exports.disableMyAccount = catchAsync(async (req, res, next) => {
  req.user.accountStatus = false;
  await req.user.save({ validateBeforeSave: false });
  console.log(req.user);
  res.status(201).json({
    status: "Success",
    message: "votre compte est maintenant désactiver",
  });
});

exports.updateMyLocation = catchAsync(async (req, res, next) => {
  req.user.location = {
    type: "Point",
    coordinates: req.body.location.coordinates,
  };
  await req.user.save({ validateBeforeSave: false });
  console.log(req.user);
  res.status(201).json({
    status: "Success",
  });
});

