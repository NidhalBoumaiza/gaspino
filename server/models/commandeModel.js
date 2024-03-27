const mongoose = require("mongoose");
const validator = require("validator");

const commandeSchema = mongoose.Schema({
  products: [
    {
      product: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Product",
      },
      quantity: {
        type: Number,
        required: [true, "Veuillez fournir une quantité pour le produit"],
      },
      produitStatus: {
        type: String,
        enum: ["pending", "accepted", "rejected"],
        default: "pending",
      },
      recoveryDate: {
        type: Date,
        required: [
          true,
          "Veuillez fournir une date de récupération pour le produit",
        ],
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
});

const Commande = mongoose.model("Commande", commandeSchema);

module.exports = Commande;
