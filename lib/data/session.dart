import 'package:Sarh/data/model/company.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/user.dart';
import 'dart:convert';

const KEY_TOKEN = 'token';
const KEY_USER = 'user';
const KEY_COMPANY = 'company';

class Session {
  final SharedPreferences _preferences;

  Session(this._preferences);

  Future<bool> saveUser(String token, User user, [Company company]) async {
    await _preferences.setString(KEY_TOKEN, token);
    await _preferences.setString(KEY_USER, jsonEncode(user));
    if (company != null)
      await _preferences.setString(KEY_COMPANY, jsonEncode(company));
    return true;
  }

  Future<bool> isCompany() async {
    return user.accountType == 2;
  }

  User get user => User.fromJson(jsonDecode(_preferences.getString(KEY_USER)));

  Company get company =>
      Company.fromJson(jsonDecode(_preferences.getString(KEY_COMPANY)));

  String get token => _preferences.getString(KEY_TOKEN) ?? "";
}
