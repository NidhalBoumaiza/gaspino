const Product = require("../models/productModel");
const User = require("../models/userModel");
const AppError = require("../utils/appError");
const catchAsync = require("../utils/catchAsync");

exports.addProduct = catchAsync(async (req, res, next) => {
  let newProduct = null;
  if (req.file) req.body.productPicture = req.file.filename;
  newProduct = await Product.create({
    productPicture: req.body.productPicture,
    name: req.body.name,
    description: req.body.description,
    priceBeforeReduction: req.body.priceBeforeReduction,
    priceAfterReduction: req.body.priceAfterReduction,
    quantity: req.body.quantity,
    expirationDate: req.body.expirationDate,
    recoveryDate: req.body.recoveryDate,
    productOwner: req.user.id,
    coordinate: req.body.coordinate,
  });

  res.status(201).json({
    status: "success",
    data: {
      newProduct,
    },
  });
});

exports.updateProduct = catchAsync(async (req, res, next) => {
  const product = await Product.findById(req.params.id);
  if (!product) {
    return next(new AppError("Aucun produit trouvé", 400));
  }
  if (req.file) req.body.profilePicture = req.file.filename;
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
    data: {
      updatedProduct,
    },
  });
});

exports.deleteProduct = catchAsync(async (req, res, next) => {
  const product = await Product.findById(req.params.id);
  if (!product) {
    return next(new AppError("Aucun produit trouvé", 400));
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

  // Maximum distance in meters (for example, 5000 meters = 5 kilometers)
  const maxDistance = req.query.distance || 5000;

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
    data: {
      products,
    },
  });
});

exports.getMyProducts = catchAsync(async (req, res, next) => {
  const products = await Product.find({ productOwner: req.user.id });
  if (products.length === 0) {
    return next(new AppError("Vous n'avez pas encore de produits", 400));
  }
  res.status(200).json({
    status: "success",
    data: {
      products,
    },
  });
});

exports.getProductsByName = catchAsync(async (req, res, next) => {
  const products = await Product.find({ name: req.params.name });
  if (products.length === 0) {
    return next(new AppError("Aucun produit trouvé", 400));
  }
  res.status(200).json({
    status: "success",
    data: {
      products,
    },
  });
});
