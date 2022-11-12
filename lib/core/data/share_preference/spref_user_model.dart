import 'package:develop_app_hoangnm/core/data/share_preference/spref_base_model.dart';

class SPrefUserModel extends SPrefBaseModel {
  static SPrefUserModel? _instance;

  static const String accessTokenKey = "ACCESS_TOKEN";
  static const String refreshTokenKey = "REFRESH_TOKEN";
  static const String expirationKey = "EXPIRATION";
  static const String expiresKey = "EXPIRES";
  static const String rememberMeKey = "REMEMBER_ME";
  static const String emailKey = "EMAIL";
  static const String passwordKey = "PASSWORD";

  SPrefUserModel._();

  factory SPrefUserModel() => _instance ??= SPrefUserModel._();

  /// Remove data local follow key
  Future<bool> removeDataUser(String key) async {
    return await removeData(key: key);
  }

  Future<bool> setAccessToken(String accessToken) async {
    return await setString(key: accessTokenKey, value: accessToken);
  }

  String? getAccessToken() {
    return getString(key: accessTokenKey, defaultValue: null);
  }

  Future<bool> setRefreshToken(String refreshToken) async {
    return await setString(key: refreshTokenKey, value: refreshToken);
  }

  String? getRefreshToken() {
    return getString(key: refreshTokenKey, defaultValue: null);
  }

  Future<bool> setRemember(bool rememberMe) async {
    return await setBool(key: rememberMeKey, value: rememberMe);
  }

  bool? getRemember() {
    return getBool(key: rememberMeKey, defaultValue: false);
  }

  Future<bool> setExpiration(String expiration) async {
    return await setString(key: expirationKey, value: expiration);
  }

  String? getExpiration() {
    return getString(key: expirationKey, defaultValue: null);
  }

  Future<bool> setExpires(double expires) async {
    return await setDouble(key: expiresKey, value: expires);
  }

  double? getExpires() {
    return getDouble(key: expiresKey, defaultValue: 0.0);
  }

  Future<bool> setEmail(String email) async {
    return await setString(key: emailKey, value: email);
  }

  String? getEmail() {
    return getString(key: emailKey, defaultValue: null);
  }

  Future<bool> setPassword(String password) async {
    return await setString(key: passwordKey, value: password);
  }

  String? getPassword() {
    return getString(key: passwordKey, defaultValue: null);
  }
}
