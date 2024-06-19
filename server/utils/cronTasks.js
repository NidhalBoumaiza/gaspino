const cron = require("node-cron");
const mongoose = require("mongoose");
const Product = require("../models/productModel"); // adjust the path to your product model
const Commande = require("../models/commandeModel"); // adjust the path to your commande model
exports.updateProductStatus = () => {
  cron.schedule("2 * * * *", async function () {
    console.log("Running cron job to update product statuses");
    const now = new Date();

    const expiredProducts = await Product.find({
      expirationDate: { $lt: now },
    });

    for (let product of expiredProducts) {
      product.Expired = true;
      await product.save();
    }

    console.log("Updated product statuses");
  });
};

exports.updateOrderedProductStatusToRejected = () => { 
  cron.schedule("* * * * *", async function () {
    const commandes = await Commande.find();
   
    for (let commande of commandes) {
      for (let product of commande.products) {
        // Assuming `product.productId.expirationDate` is the expiration date of the product
        let expirationDate = new Date(product.productId.expirationDate);
        let now = new Date();
    
        if (now >= expirationDate) {
          product.ordredProduitStatus = "rejected";
        }
      }
    
      // Save the updated commande document
      await commande.save();
    }
    console.log("Updated ordered product statuses");
  });
};
