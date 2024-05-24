const Product = require("../models/productModel");
const User = require("../models/userModel");
const AppError = require("../utils/appError");
const catchAsync = require("../utils/catchAsync");
const path = require("path");
const fs = require("fs");
const {
  deleteImageProductFromFolder,
} = require("../utils/deleteImageFromFolder");

exports.addProduct = catchAsync(async (req, res, next) => {
  let newProduct = null;
  req.body.images = [];
  if (req.files) {
    for (let i = 0; i < req.files.length; i++) {
      req.body.images.push(req.files[i].filename);
    }
  }
  req.body.recoveryDate = req.body.recoveryDate.replace(/(\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{6})/g, '"$1"');
  req.body.recoveryDate = JSON.parse(req.body.recoveryDate);
  newProduct = await Product.create({
    productPictures: req.body.images,
    name: req.body.name,
    description: req.body.description,
    priceBeforeReduction: req.body.priceBeforeReduction,
    priceAfterReduction: req.body.priceAfterReduction,
    quantity: req.body.quantity,
    expirationDate: req.body.expirationDate,
    recoveryDate: req.body.recoveryDate,
    productOwner: req.user.id,
    location: {
      type: "Point",
      coordinates: JSON.parse(req.body.coordinates),
    },
  });

  res.status(201).json({
    status: "success",
   
      newProduct,
    
  });
});

exports.getMyProducts = catchAsync(async (req, res, next) => {
  const products = await Product.find({ productOwner: req.user.id });
  if (products.length === 0) {
    return next(new AppError("Vous n'avez pas encore de produits", 400));
  }
  res.status(200).json({
    status: "success",
    ProductNumber: products.length,
    
      products,

  });
});

exports.updateProduct = catchAsync(async (req, res, next) => {
  const product = await Product.findById(req.params.id);
  if (!product) {
    return next(new AppError("Aucun produit trouvé", 400));
  }
  req.body.productPictures = JSON.parse(req.body.productPictures);

  if (req.files) {
    for (let i = 0; i < req.files.length; i++) {
      req.body.productPictures.push(req.files[i].filename);
    }
  }

  imagestoDelete = [];

  product.productPictures.forEach((image) => {
    if (!req.body.productPictures.includes(image)) {
      imagestoDelete.push(image);
    }
  });
  deleteImageProductFromFolder(imagestoDelete);
  const updatedProduct = await Product.findByIdAndUpdate(
    req.params.id,
    req.body,
    {
      new: true,
      runValidators: true,
    }
  );
  res.status(200).json({
    status: "success",
      updatedProduct,
  });
});

exports.deleteProduct = catchAsync(async (req, res, next) => {
  const product = await Product.findById(req.params.id);
  if (!product) {
    return next(new AppError("Aucun produit trouvé", 400));
  }
  if (product.productPictures.length > 0) {
    deleteImageProductFromFolder(product.productPictures);
  }

  await Product.findByIdAndDelete(req.params.id);
  res.status(204).json({
    status: "success",
    data: null,
  });
});

exports.getAllProductsWithDistance = catchAsync(async (req, res, next) => {
  const userLocation = [
    req.user.location.coordinates[0],
    req.user.location.coordinates[1],
  ];

  const maxDistance = req.query.distance || 5000;
  console.log(maxDistance);
  const products = await Product.find({
    location: {
      $near: {
        $geometry: {
          type: "Point",
          coordinates: userLocation,
        },
        $maxDistance: maxDistance,
      },
    },
  });
  if (products.length === 0) {
    return next(new AppError("Aucun produit trouvé dans votre zone", 400));
  }
  res.status(200).json({
    status: "success",
    productsNumber: products.length,
      products,
  });
});

exports.getAllProductsWithDistanceExpiresToday = catchAsync(async (req, res, next) => {
  const userLocation = [
    req.user.location.coordinates[0],
    req.user.location.coordinates[1],
  ];

  const maxDistance = req.query.distance || 5000;
  const today = new Date();
  today.setHours(0, 0, 0, 0);
  const tomorrow = new Date(today);
  tomorrow.setDate(tomorrow.getDate() + 1);
  tomorrow.setHours(0, 0, 0, 0);
  console.log(today);
  console.log(tomorrow);
  console.log(Date());
  const products = await Product.find({
    location: {
      $near: {
        $geometry: {
          type: "Point",
          coordinates: userLocation,
        },
        $maxDistance: maxDistance,
      },
    },
    expirationDate: {
      $gte: today,
      $lt: tomorrow,
    },
  });
  
  if (products.length === 0) {
    return next(new AppError("Aucun produit trouvé dans votre zone", 400));
  }
  res.status(200).json({
    status: "success",
    productsNumber: products.length,
      products,
  });
});

exports.searchProductByName = catchAsync(async (req, res, next) => {
  const products = await Product.find({
    name: { $regex: `^${req.query.productName}`, $options: "i" },
  });
  if (products.length === 0) {
    return next(new AppError("Aucun produit trouvé", 400));
  }
  res.status(200).json({
    status: "success",
    productsNumber: products.length,
      products,
  });
});

exports.getProductById = catchAsync(async (req, res, next) => {
  const product = await Product.findById(req.params.id);
  if (!product) {
    return next(new AppError("Aucun produit trouvé", 400));
  }
  res.status(200).json({
    status: "success",
      product,
  });
});
