const cron = require("node-cron");
const mongoose = require("mongoose");
const Product = require("../models/productModel"); // adjust the path to your product model

exports.updateProductStatus = () => {
  cron.schedule("0 * * * *", async function () {
    const now = new Date();

    const expiredProducts = await Product.find({
      expirationDate: { $lt: now },
    });

    for (let product of expiredProducts) {
      product.productStatus = true;
      await product.save();
    }

    console.log("Updated product statuses");
  });
};
