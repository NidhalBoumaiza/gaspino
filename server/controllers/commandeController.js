const Product = require("../models/productModel");
const User = require("../models/userModel");
const Commande = require("../models/commandeModel");
const AppError = require("../utils/appError");
const catchAsync = require("../utils/catchAsync");
const path = require("path");
const fs = require("fs");
const { verify } = require("crypto");

exports.commanderCommande = catchAsync(async (req, res, next) => {
  // console.log(req.body.products[0]);

  for (let product of req.body.products) {
    console.log(product);
    const produitFromDataBase = await Product.findById(product.productId);
    console.log(produitFromDataBase.quantity, product.quantity);
    if (produitFromDataBase.quantity < product.quantity) {
      return next(
        new AppError(
          `Quantité insuffisante pour le produit ${produitFromDataBase.name} Quantité disponible pour commander: ${produitFromDataBase.quantity}`,
          400
        )
      );
    }
  }

  const commande = await Commande.create({
    products: req.body.products,
    commandeOwner: req.user.id,
  });
  res.status(201).json({
    status: "success",
      commande,
  });
});

exports.getMyCommandes = catchAsync(async (req, res, next) => {
  const commandes = await Commande.find({ commandeOwner: req.user.id });
  if (commandes.length === 0) {
    return next(new AppError("Vous n'avez pas encore de commandes", 400));
  }
  res.status(200).json({
    status: "success",
    
      commandes,
    
  });
});

exports.getWhoCommandedMyProduct = catchAsync(async (req, res, next) => {
  const commandes = await Commande.find().sort("-createdAt");

  let myOrderedProducts = [];
  for (let commande of commandes) {
    for (let product of commande.products) {  
      console.log(product.productId);
      if (product.productId.productOwner.id === req.user.id) {
        myOrderedProducts.push({
          product,
          commandeOwner: commande.commandeOwner,
          commandeId: commande._id,
        });
      }
    }
  }
  if (myOrderedProducts.length === 0) {
    return next(new AppError("Vous n'avez pas des produits Commandés", 400));
  }
  res.status(200).json({
    status: "success",
    myOrderedProductsNumber: myOrderedProducts.length,

    myOrderedProducts,
  });
});

exports.CancelMyCommande = catchAsync(async (req, res, next) => {
  let commande = await Commande.findOne({
    _id: req.params.commandeId,
    commandeStatus: "pending",
  });

  if (!commande) {
    return next(
      new AppError("Vous n'est peut pas annuler cette commande", 400)
    );
  }
  await Commande.findByIdAndDelete(commande._id);
  res.status(200).json({
    status: "success",
  });
});

exports.cancelOneProductFromCommande = catchAsync(async (req, res, next) => {
  
  const commande = await Commande.findById(req.params.commandeId);
  if (!commande) {
    return next(new AppError("Commande non trouvé", 400));
  }
  console.log(req.params.productId)
  console.log (commande)
  let product = commande.products.find(
    (product) => {
      return product.productId.equals(req.params.productId); 
    }
  );
  if (!product) {
    return next(new AppError("Produit non trouvé", 400));
  }

  product.ordredProduitStatus = "cancelled"; // Update the status to cancelled

  await commande.save();

  res.status(200).json({
    status: "success",
    product,
  });
});


exports.updateProductStatusToDelivered = catchAsync(async (req, res, next) => {
  let commande = await Commande.findById(req.params.commandeId);
  if (!commande) {
    return next(new AppError("Commande non trouvé", 400));
  }

  let product = commande.products.find(product => product.productId._id.toString() === req.params.productId);
  if (!product) {
    return next(new AppError("Produit non trouvé", 400));
  }

  const produitFromDataBase = await Product.findById(product.productId);

  if (produitFromDataBase.quantity < product.quantity) {
    return next(
      new AppError(
        `Quantité insuffisante pour le produit ${produitFromDataBase.name} Quantité disponible pour commander: ${produitFromDataBase.quantity}`,
        400
      )
    );
  }

  product.ordredProduitStatus = "delivered";

  await User.updateOne(
    { _id: req.user.id },
    {
      $inc: {
        income: product.productId.priceAfterReduction * product.quantity,
      },
    }
  );
  await Product.updateOne(
    { _id: product.productId },
    {
      $inc: {
        quantity: -product.quantity,
      },
    },
    {
      new: true,
    }
  );

  await commande.save();

  // Reload the commande object from the database
  commande = await Commande.findById(req.params.commandeId);

  // Check if all products are delivered
  if (commande.products.every(product => product.ordredProduitStatus === "delivered")) {
    commande.status = "delivered";
  }

  await commande.save();

  res.status(200).json({
    status: "success",
    product,
  });
});



