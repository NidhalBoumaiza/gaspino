const mongoose = require("mongoose");
const validator = require("validator");

const productSchema = mongoose.Schema({
  productPictures: {
    type: [String],
    default: `defaultProduct${Math.floor(Math.random() * 4) + 1}.jpg`,
  },
  name: {
    type: String,
    required: [true, "Veuillez fournir un nom pour le produit"],
  },
  description: {
    type: String,
  },
  priceBeforeReduction: {
    type: Number,
  },
  priceAfterReduction: {
    type: Number,
    required: [true, "Veuillez fournir un prix pour le produit"],
  },
  quantity: {
    type: Number,
    required: [true, "Veuillez fournir une quantité pour le produit"],
  },
  expirationDate: {
    type: Date,
    required: [true, "Veuillez fournir une date d'expiration pour le produit"],
    default: () => {
      const endOfDay = new Date();
      endOfDay.setHours(23, 59, 59, 999);
      return endOfDay;
    },
  },
  recoveryDate: {
    type: [Date],
    default: () => {
      const sixPM = new Date();
      sixPM.setHours(18, 0, 0, 0);
      const eightPM = new Date();
      eightPM.setHours(20, 0, 0, 0);
      return [sixPM, eightPM];
    },
  },
  productOwner: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
  },
  location: {
    type: {
      type: String,
      enum: ["Point"], // 'location.type' must be 'Point'
      required: true,
    },
    coordinates: {
      type: [Number],
      required: true,
    },
  },
  Expired: {
    type: Boolean,
    default: false,
  },
  createdAt: {
    type: Date,
    default: Date.now(),
  },
});
productSchema.pre(/^find/, function (next) {
  this.populate(
    "productOwner",
    "-password -passwordResetCode -passwordResetExpires -accountStatus -activeAccountToken -activeAccountTokenExpires"
  );
  next();
});
productSchema.index({ location: "2dsphere" });

const Product = mongoose.model("Product", productSchema);

module.exports = Product;
