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

  Future<bool> saveUser(String token, User user, Company company) async {
    await _preferences.setString(KEY_TOKEN, token);
    await _preferences.setString(KEY_USER, jsonEncode(user.toJson()));
    if (company != null)
      await _preferences.setString(KEY_COMPANY, jsonEncode(company.toJson()));
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
