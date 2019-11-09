/*
 * Copyright (c) 2019.
 *           ______             _
 *          |____  |           | |
 *  _ __ ___    / / __ ___   __| |_ __ __ _
 * | '_ ` _ \  / / '_ ` _ \ / _` | '__/ _` |
 * | | | | | |/ /| | | | | | (_| | | | (_| |
 * |_| |_| |_/_/ |_| |_| |_|\__,_|_|  \__,_|
 *
 *
 *
 *
 */

import 'package:Sarh/data/model/company.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/user.dart';
import 'dart:convert';

const KEY_TOKEN = 'token';
const KEY_USER = 'user';
const KEY_COMPANY = 'company';
const KEY_COMPANY_ID = 'company_id';
const KEY_USER_ID = 'user_id';

class Session {
  final SharedPreferences _preferences;

  Session(this._preferences);

  Future<bool> saveUser(String token, User user, Company company) async {
    await _preferences.setString(KEY_TOKEN, token);
    await _preferences.setString(KEY_USER, jsonEncode(user.toJson()));
    await _preferences.setInt(KEY_USER_ID, user.id);
    if (company != null)
      await _preferences.setString(KEY_COMPANY, jsonEncode(company.toJson()));
      await _preferences.setInt(KEY_COMPANY_ID, company.id);
    return true;
  }

  bool get isCompany => user.accountType == 2;

  bool get companyProfileCompleted => isCompany && company != null;

  User get user => User.fromJson(jsonDecode(_preferences.getString(KEY_USER)));

  Company get company =>
      _companyFromPreference != null && _companyFromPreference.isNotEmpty
          ? Company.fromJson(jsonDecode(_companyFromPreference))
          : null;

  String get _companyFromPreference => _preferences.getString(KEY_COMPANY);

  String get token => _preferences.getString(KEY_TOKEN) ?? null;

  Future<bool> clear() {
    return _preferences.clear();
  }

  Future<void> reload() {
    return _preferences.reload();
  }
}
