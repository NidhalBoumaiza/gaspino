import 'dart:convert';

import 'package:client/features/commande/data%20layer/models/commande_model.dart';
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
  Future<void> cacheWhoCommandedMyProduct(List<CommandeModel> commandes) async {
    final List<String> jsonCommandes =
        commandes.map((commande) => json.encode(commande.toJson())).toList();
    await sharedPreferences.setStringList(
        'CACHED_WHO_COMMANDED_MY_PRODUCT', jsonCommandes);
  }

  @override
  Future<List<CommandeModel>> getWhoCommandedMyProduct() async {
    final jsonStringList =
        sharedPreferences.getStringList('CACHED_WHO_COMMANDED_MY_PRODUCT');
    if (jsonStringList != null) {
      final List<CommandeModel> commandes = jsonStringList
          .map((jsonString) => CommandeModel.fromJson(json.decode(jsonString)))
          .toList();
      return commandes;
    } else {
      throw EmptyCacheException();
    }
  }
}
