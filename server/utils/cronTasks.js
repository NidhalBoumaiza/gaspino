const cron = require("node-cron");
const mongoose = require("mongoose");
const Product = require("../models/productModel"); // adjust the path to your product model

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
