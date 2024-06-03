import 'dart:convert';

import 'package:client/features/products/data%20layer/models/product_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';

abstract class ProductLocalDataSource {
  Future<Unit> cacheProductsWithinDistance(List<ProductModel> products);

  Future<Unit> cacheMyProducts(List<ProductModel> products);

  Future<List<ProductModel>> getProductsWithinDistance();

  Future<List<ProductModel>> getMyProducts();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cacheMyProducts(List<ProductModel> products) {
    final productsToJson = products.map((product) => product.toJson()).toList();
    final productsJson = jsonEncode(productsToJson); // Correctly encode to JSON
    sharedPreferences.setString('myProducts', productsJson);
    return Future.value(unit);
  }

  @override
  Future<Unit> cacheProductsWithinDistance(List<ProductModel> products) {
    final productsToJson = products.map((product) => product.toJson()).toList();
    final productsJson = jsonEncode(productsToJson);
    sharedPreferences.setString('productsWithinDistance', productsJson);
    return Future.value(unit);
  }

  @override
  Future<List<ProductModel>> getMyProducts() {
    final myProductsJson = sharedPreferences.getString('myProducts');
    if (myProductsJson != null) {
      final decodeJson = json.decode(myProductsJson) as List;
      final jsonToProducts = decodeJson
          .map((productJson) => ProductModel.fromJson(productJson))
          .toList();
      return Future.value(jsonToProducts);
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<List<ProductModel>> getProductsWithinDistance() {
    final productsWithinDistanceJson =
        sharedPreferences.getString('productsWithinDistance');

    if (productsWithinDistanceJson != null) {
      final decodeJson = json.decode(productsWithinDistanceJson);
      print(decodeJson);
      final List<ProductModel> products = decodeJson
          .map<ProductModel>((product) => ProductModel.fromJson(product))
          .toList();

      return Future.value(products);
    } else {
      throw EmptyCacheException();
    }
  }
}
