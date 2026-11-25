import 'dart:convert';

import 'package:masrofy/core/services/shared_preferences.dart';
import 'package:masrofy/features/auth/data/user_model.dart';

abstract class AuthLocalDataSource {
  bool isLoggedIn();
  UserModel? getSavedUser();
  Future<UserModel> saveLocalUser(UserModel user);
  Future<void> clearSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const _userKey = 'masrofy_local_user';
  static const _isLoggedInKey = 'masrofy_is_logged_in';

  @override
  bool isLoggedIn() {
    return SPService.getBool(_isLoggedInKey) ?? false;
  }

  @override
  UserModel? getSavedUser() {
    final raw = SPService.getString(_userKey);
    if (raw == null || raw.isEmpty) return null;
    return UserModel.fromMap(jsonDecode(raw) as Map<String, dynamic>);
  }

  @override
  Future<UserModel> saveLocalUser(UserModel user) async {
    await SPService.setString(_userKey, jsonEncode(user.toMap()));
    await SPService.setBool(_isLoggedInKey, true);
    return user;
  }

  @override
  Future<void> clearSession() async {
    await SPService.setBool(_isLoggedInKey, false);
  }
}
