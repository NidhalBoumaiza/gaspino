import 'dart:convert';

import 'package:client/features/products/data%20layer/models/product_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

abstract class ProductRemoteDataSource {
  Future<Unit> addProduct(ProductModel productModel);

  Future<List<ProductModel>> getAllProductsWithinDistance(num? distance);

  Future<List<ProductModel>> getAllProductsWithinDistanceExpiresToday(
      num? distance);

  Future<List<ProductModel>> getMyProducts();

  Future<Unit> deleteMyProduct(String id);

  Future<List<ProductModel>> searchProductByName(String name);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<Unit> addProduct(ProductModel productModel) async {
    List<String> imagePaths = productModel.productPictures;
    List<http.MultipartFile> imageParts = [];
    for (String imagePath in imagePaths) {
      var imagePart = await http.MultipartFile.fromPath(
        'images',
        imagePath,
        contentType: MediaType('images', 'jpg'),
      );

      imageParts.add(imagePart);
    }

    final request = http.MultipartRequest(
      'POST',
      Uri.parse("${dotenv.env['URL']}/products/addProduct"),
    );
    final token = await this.token;

    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    });
    request.fields.addAll({
      "name": productModel.name,
      "priceBeforeReduction": productModel.priceBeforeReduction.toString(),
      "quantity": productModel.quantity.toString(),
      "expirationDate": productModel.expirationDate.toIso8601String(),
      "coordinates": jsonEncode(productModel.location.coordinates),
      "expired": productModel.expired.toString(),
      "createdAt": productModel.createdAt.toIso8601String(),
    });
    if (productModel.description != null) {
      request.fields.addAll({
        "description": productModel.description.toString(),
      });
    }
    if (productModel.priceBeforeReduction != null) {
      request.fields.addAll({
        "priceAfterReduction": productModel.priceAfterReduction.toString(),
      });
    }
    if (productModel.recoveryDate != null) {
      request.fields.addAll({
        'recoveryDate': jsonEncode(productModel.recoveryDate
            ?.map((date) => date?.toIso8601String())
            .toList()),
      });
    }
    request.files.addAll(imageParts);
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return handleResponse(response);
  }

  Future<List<ProductModel>> getAllProductsWithinDistance(num? distance) async {
    final token = await this.token;
    final response = await client.get(
      Uri.parse(
          "${dotenv.env['URL']}/products/getPoductsWithinDistance/?distance=$distance"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final decodeJson = json.decode(response.body);

      final List<ProductModel> products = decodeJson['products']
          .map<ProductModel>((product) => ProductModel.fromJson(product))
          .toList();
      return products;
    } else if (response.statusCode == 400) {
      final responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['message'] as String;

      ServerMessageFailure.message = errorMessage;

      throw ServerMessageException();
    } else if (response.statusCode == 410) {
      throw const UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  Future<List<ProductModel>> getAllProductsWithinDistanceExpiresToday(
      num? distance) async {
    final token = await this.token;
    final response = await client.get(
      Uri.parse(
          "${dotenv.env['URL']}/products/getProductsWithinDistanceExpiresToday/?distance=$distance"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final decodeJson = json.decode(response.body);

      final List<ProductModel> products = decodeJson['products']
          .map<ProductModel>((product) => ProductModel.fromJson(product))
          .toList();
      return products;
    } else if (response.statusCode == 400) {
      final responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['message'] as String;

      ServerMessageFailure.message = errorMessage;

      throw ServerMessageException();
    } else if (response.statusCode == 410) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  Future<List<ProductModel>> getMyProducts() async {
    final token = await this.token;
    final response = await client.get(
      Uri.parse("${dotenv.env['URL']}/products/getMyProducts"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final decodeJson = json.decode(response.body);

      final List<ProductModel> products = decodeJson['products']
          .map<ProductModel>((product) => ProductModel.fromJson(product))
          .toList();

      return products;
    } else if (response.statusCode == 400) {
      final responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['message'] as String;

      ServerMessageFailure.message = errorMessage;

      throw ServerMessageException();
    } else if (response.statusCode == 410) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  Future<Unit> deleteMyProduct(String id) async {
    final token = await this.token;
    final response = await client.delete(
      Uri.parse("${dotenv.env['URL']}/products/deleteMyProduct/$id"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    return handleResponse(response);
  }

  @override
  Future<Unit> updateMyProduct(ProductModel productModel, String id) async {
    List<String> imagePaths = productModel.productPictures;
    List<http.MultipartFile> imageParts = [];
    for (String imagePath in imagePaths) {
      var imagePart = await http.MultipartFile.fromPath(
        'images',
        imagePath,
        contentType: MediaType('images', 'jpg'),
      );

      imageParts.add(imagePart);
    }

    final request = http.MultipartRequest(
      'PATCH',
      Uri.parse("${dotenv.env['URL']}/products/updateProduct/$id"),
    );
    final token = await this.token;

    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    });
    request.fields.addAll({
      "name": productModel.name,
      "priceBeforeReduction": productModel.priceBeforeReduction.toString(),
      "quantity": productModel.quantity.toString(),
      "expirationDate": productModel.expirationDate.toIso8601String(),
      "coordinates": jsonEncode(productModel.location.coordinates),
      "expired": productModel.expired.toString(),
      "createdAt": productModel.createdAt.toIso8601String(),
    });
    if (productModel.description != null) {
      request.fields.addAll({
        "description": productModel.description.toString(),
      });
    }
    if (productModel.priceBeforeReduction != null) {
      request.fields.addAll({
        "priceAfterReduction": productModel.priceAfterReduction.toString(),
      });
    }
    if (productModel.recoveryDate != null) {
      request.fields.addAll({
        'recoveryDate': jsonEncode(productModel.recoveryDate
            ?.map((date) => date?.toIso8601String())
            .toList()),
      });
    }
    request.files.addAll(imageParts);
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    return handleResponse(response);
  }

  Future<Failure> handleResponseWithoutUnit(http.Response response) async {
    if (response.body.isNotEmpty) {
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 400) {
        final errorMessage = responseBody['message'] as String;
        ServerMessageFailure.message = errorMessage;
        throw ServerMessageException();
      } else if (response.statusCode == 410) {
        final errorMessage = responseBody['message'] as String;
        UnauthorizedFailure.message = errorMessage;
        throw const UnauthorizedException();
      } else {
        throw ServerException();
      }
    } else {
      // Handle empty response body
      throw FormatException("Empty response body");
    }
  }

  Future<Unit> handleResponse(http.Response response) async {
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      return Future.value(unit);
    } else {
      // Check if the response body is not empty
      if (response.body.isNotEmpty) {
        final responseBody = jsonDecode(response.body);

        if (response.statusCode == 400) {
          final errorMessage = responseBody['message'] as String;
          ServerMessageFailure.message = errorMessage;
          throw ServerMessageException();
        } else if (response.statusCode == 410) {
          final errorMessage = responseBody['message'] as String;
          UnauthorizedFailure.message = errorMessage;
          throw const UnauthorizedException();
        } else {
          throw ServerException();
        }
      } else {
        // Handle empty response body
        throw FormatException("Empty response body");
      }
    }
  }

  Future<dynamic> get token async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  @override
  Future<List<ProductModel>> searchProductByName(String name) async {
    final token = await this.token;
    final response = await client.get(
      Uri.parse(
          "${dotenv.env['URL']}/products/searchProductByName/?productName=$name"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final decodeJson = json.decode(response.body);
      final List<ProductModel> products = decodeJson['products']
          .map<ProductModel>((product) => ProductModel.fromJson(product))
          .toList();
      return products;
    } else if (response.statusCode == 400) {
      final responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['message'] as String;
      ServerMessageFailure.message = errorMessage;
      throw ServerMessageException();
    } else if (response.statusCode == 410) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }
}
