import 'package:develop_app_hoangnm/core/data/share_preference/spref_base_model.dart';

class SPrefUserModel extends SPrefBaseModel {
  static SPrefUserModel? _instance;
  static const String emailKey = "EMAIL";
  static const String passwordKey = "PASSWORD";

  SPrefUserModel._();

  factory SPrefUserModel() => _instance ??= SPrefUserModel._();

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
