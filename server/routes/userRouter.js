const express = require("express");
const authController = require("../controllers/authController");
const userController = require("../controllers/userController");
const uploadd = require("../utils/upload");
const router = express.Router();
router.route("/signup").post(uploadd.uploadPicture, authController.signUp);
router.route("/accountActivation/:token").get(authController.activeAccount);
router.post("/refreshToken", authController.refreshToken);
router.route("/imageupload").post(uploadd.uploadPicture);
router.route("/forgotpassword").post(authController.forgotPassword);
router.route("/resetPasswordStepOne").post(authController.resetPasswordStepOne);
router
  .route("/resetPasswordStepTwo")
  .patch(authController.resetPasswordStepTwo);

router.route("/login").post(authController.login);

router
  .route("/updateUserPassword")
  .patch(authController.protect, authController.updateUserPassword);

router
  .route("/updateCoordinate")
  .patch(authController.protect, userController.updateMyLocation);

router
  .route("/disableMyAccount")
  .patch(authController.protect, userController.disableMyAccount);

module.exports = router;
