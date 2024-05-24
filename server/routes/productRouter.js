const express = require("express");
const productController = require("../controllers/productController");
const authController = require("../controllers/authController");
const uploadd = require("../utils/upload");
const router = express.Router();

router
  .route("/addProduct")
  .post(
    authController.protect,
    uploadd.uploadMultiplePicture,
    productController.addProduct
  );

router
  .route("/getMyProducts/")
  .get(authController.protect, productController.getMyProducts);

router
  .route("/updateMyProduct/:id")
  .patch(
    authController.protect,
    uploadd.uploadMultiplePicture,
    productController.updateProduct
  );

router
  .route("/deleteMyProduct/:id")
  .delete(authController.protect, productController.deleteProduct);

router
  .route("/getPoductsWithinDistance/")
  .get(authController.protect, productController.getAllProductsWithDistance);

  router
  .route("/getProductsWithinDistanceExpiresToday/")
  .get(authController.protect, productController.getAllProductsWithDistanceExpiresToday);

router
  .route("/searchProductByName/")
  .get(authController.protect, productController.searchProductByName);

router
  .route("/getProductById/:id")
  .get(authController.protect, productController.getProductById);

module.exports = router;
