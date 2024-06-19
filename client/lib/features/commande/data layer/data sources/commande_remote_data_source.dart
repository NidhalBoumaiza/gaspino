import 'dart:convert';

import 'package:client/features/commande/data%20layer/models/commande_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

abstract class CommandeRemoteDataSource {
  Future<Unit> passerCommande(dynamic commandeModel);

  Future<List<CommandeModel>> getMyCommandes();

  Future<Unit> cancelOneProductFromCommande(
      String commandeId, String productId);

  Future<List<CommandeModel>> getWhoCommandedMyProduct();

  Future<Unit> updateProductStatusToDelivered(
      String commandeId, String productId);
}

class CommandeRemoteDataSourceImpl implements CommandeRemoteDataSource {
  final http.Client client;

  CommandeRemoteDataSourceImpl({required this.client});

  @override
  Future<Unit> passerCommande(dynamic commandeModel) async {
    final token = await this.token;
    dynamic body = {"products": commandeModel};
    body = json.encode(body);

    final response = await client.post(
      Uri.parse("${dotenv.env['URL']}/commandes/passerCommande"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );
    print(response.body);
    return handleResponse(response);
  }

  @override
  Future<List<CommandeModel>> getMyCommandes() async {
    final token = await this.token;
    final response = await client.get(
      Uri.parse("${dotenv.env['URL']}/commandes/getMyCommandes"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final decodeJson = json.decode(response.body);
      final List<CommandeModel> commandes = decodeJson['commandes']
          .map<CommandeModel>((commande) => CommandeModel.fromJson(commande))
          .toList();
      return commandes;
    } else {
      return handleResponseWithoutUnit(response);
    }
  }

  @override
  Future<List<CommandeModel>> getWhoCommandedMyProduct() async {
    final token = await this.token;
    final response = await client.get(
      Uri.parse("${dotenv.env['URL']}/commandes/getWhoCommandedMyProduct"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final decodeJson = json.decode(response.body);

      final List<CommandeModel> commandes =
          decodeJson['myOrderedProducts'].map<CommandeModel>((commande) {
        return CommandeModel.fromJson(commande);
      }).toList();
      return commandes;
    } else {
      return handleResponseWithoutUnit(response);
    }
  }

  @override
  Future<Unit> cancelOneProductFromCommande(
      String commandeId, String productId) async {
    final token = await this.token;
    final response = await client.patch(
      Uri.parse(
          "${dotenv.env['URL']}/commandes/cancelOneProductFromCommande/$commandeId/$productId"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    return handleResponse(response);
  }

  @override
  Future<Unit> updateProductStatusToDelivered(
      String commandeId, String productId) async {
    final token = await this.token;
    final response = await client.patch(
      Uri.parse(
          "${dotenv.env['URL']}/commandes/updateProductStatusToDelivered/$commandeId/$productId"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    return handleResponse(response);
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

  Future<List<CommandeModel>> handleResponseWithoutUnit(
      http.Response response) async {
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

  Future<dynamic> get token async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }
}
