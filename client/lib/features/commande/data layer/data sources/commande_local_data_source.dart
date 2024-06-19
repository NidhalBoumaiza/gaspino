import 'dart:convert';

import 'package:client/features/commande/data%20layer/models/commande_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';

abstract class CommandeLocalDataSource {
  Future<void> cacheMyCommandes(List<CommandeModel> commandes);

  Future<List<CommandeModel>> getMyCommandes();

  Future<void> cacheWhoCommandedMyProduct(List<CommandeModel> commandes);

  Future<List<CommandeModel>> getWhoCommandedMyProduct();
}

class CommandeLocalDataSourceImpl implements CommandeLocalDataSource {
  final SharedPreferences sharedPreferences;

  CommandeLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheMyCommandes(List<CommandeModel> commandes) async {
    final List<String> jsonCommandes =
        commandes.map((commande) => json.encode(commande.toJson())).toList();
    await sharedPreferences.setStringList('CACHED_MY_COMMANDES', jsonCommandes);
  }

  @override
  Future<List<CommandeModel>> getMyCommandes() async {
    final jsonStringList =
        sharedPreferences.getStringList('CACHED_MY_COMMANDES');
    if (jsonStringList != null) {
      final List<CommandeModel> commandes = jsonStringList
          .map((jsonString) => CommandeModel.fromJson(json.decode(jsonString)))
          .toList();
      return commandes;
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<Unit> cacheWhoCommandedMyProduct(List<CommandeModel> commandes) {
    final commandesToJson =
        commandes.map((commande) => commande.toJson()).toList();
    final commandesJson =
        jsonEncode(commandesToJson); // Correctly encode to JSON
    sharedPreferences.setString(
        'CACHED_WHO_COMMANDED_MY_PRODUCT', commandesJson);
    return Future.value(unit);
  }

  @override
  Future<List<CommandeModel>> getWhoCommandedMyProduct() async {
    final commandesJson =
        sharedPreferences.getString('CACHED_WHO_COMMANDED_MY_PRODUCT');
    if (commandesJson != null) {
      final decodeJson = json.decode(commandesJson) as List;
      final jsonToCommandes = decodeJson
          .where((commandeJson) =>
              commandeJson != null && commandeJson is Map<String, dynamic>)
          .map((commandeJson) => CommandeModel.fromJson(commandeJson))
          .toList();
      return Future.value(jsonToCommandes);
    } else {
      throw EmptyCacheException();
    }
  }
}
