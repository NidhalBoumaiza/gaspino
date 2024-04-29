import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<Unit> cacheUser(UserModel user);

  Future<Unit> cacheToken(String token);

  Future<String> getToken();

  Future<UserModel> getUser();

  Future<Unit> signOut();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cacheUser(UserModel user) {
    dynamic userToJson = user.toJson();
    userToJson = json.encode(userToJson);
    sharedPreferences.setString('user', userToJson);
    return Future.value(unit);
  }

  @override
  Future<Unit> cacheToken(String token) {
    sharedPreferences.setString('token', token);
    return Future.value(unit);
  }

  @override
  Future<String> getToken() {
    final token = sharedPreferences.getString('token');
    if (token != null) {
      return Future.value(token);
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<UserModel> getUser() {
    final userJson = sharedPreferences.getString('user');
    if (userJson != null) {
      final decodeJson = json.decode(userJson);
      final jsonToUser = UserModel.fromJson(decodeJson);
      return Future.value(jsonToUser);
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<Unit> signOut() {
    sharedPreferences.remove('user');
    sharedPreferences.remove('token');
    sharedPreferences.remove("products");
    sharedPreferences.remove("bag");
    return Future.value(unit);
  }
}
