import 'package:shared_preferences/shared_preferences.dart';

const KEY_TOKEN = 'token';

const KEY_USER = 'user';
const KEY_USER_ID = 'user_id';
const KEY_USER_FULL_NAME = 'user_full_name';
const KEY_USER_USER_NAME = 'user_user_name';
const KEY_USER_PHONE = 'user_phone';
const KEY_USER_ACCOUNT_TYPE = 'user_account_type';
const KEY_USER_CITY='user_city';
const KEY_USER_IS_VERIFIED="user_is_verified";
const KEY_USER_FIREBASE_TOKEN="user_firebase_token";


const KEY_COMPANY = 'company';

class Session {
  final SharedPreferences _preferences;

  Session(this._preferences);
}
