const mongoose = require("mongoose");
const validator = require("validator");

const commandeSchema = mongoose.Schema({
  products: [
    {
      productId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Product",
      },
      quantity: {
        type: Number,
        required: [true, "Veuillez fournir une quantité pour le produit"],
      },
      ordredProduitStatus: {
        type: String,
        enum: ["pending", "delivered", "refused"],
        default: "pending",
      },
     
    },
  ],
  commandeStatus: {
    type: String,
    enum: ["pending", "accepted", "rejected"],
    default: "pending",
  },
  commandeOwner: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
  },
  createdAt: {
    type: Date,
    default: Date.now(),
  },
});

commandeSchema.pre(/^find/, function (next) {
  this.populate({
    path: "products.productId",
  //  select: "productPictures name priceAfterReduction quantity",
  }).populate({
    path: "commandeOwner",
   // select: "firstName lastName phoneNumber email",
  });
  next();
});

const Commande = mongoose.model("Commande", commandeSchema);

module.exports = Commande;
