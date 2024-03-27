const express = require("express");
const productController = require("../controllers/productController");
const authController = require("../controllers/authController");
const uploadd = require("../utils/upload");
const router = express.Router();

router
  .route("/addProduct")
  .post(
    authController.protect,
    uploadd.uploadPicture,
    productController.addProduct
  );
