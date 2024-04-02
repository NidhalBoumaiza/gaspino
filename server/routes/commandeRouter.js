const express = require("express");
const productController = require("../controllers/productController");
const authController = require("../controllers/authController");
const commandeController = require("../controllers/commandeController");
const router = express.Router();

router
  .route("/passerCommande")
  .post(authController.protect, commandeController.commanderCommande);

router
  .route("/getMyCommandes")
  .get(authController.protect, commandeController.getMyCommandes);

router
  .route("/getWhoCommandedMyProduct")
  .get(authController.protect, commandeController.getWhoCommandedMyProduct);

router.patch(
  "/cancelOneProductFromCommande/:commandeId:productId",
  authController.protect,
  commandeController.cancelOneProductFromCommande
);

router.patch(
  "/updateProductStatusToDelivered/:commandeId/:productId",
  authController.protect,
  commandeController.updateProductStatusToDelivered
);

module.exports = router;
