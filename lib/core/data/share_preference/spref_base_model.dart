import 'package:develop_app_hoangnm/core/utils/log_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SPrefBaseModel {
  late SharedPreferences _prefs;

  Future<void> onInit() async {
    LogUtils.i("SPrefs:onInit:$runtimeType");
    _prefs = await SharedPreferences.getInstance();
  }

  /// Remove data follow key of SharedPreferences
  Future<bool> removeData({required String key}) {
    return _prefs.remove(key);
  }

  /// Reads a value from persistent storage, throwing an exception if it's not a bool.
  bool getBool({required String key, required bool defaultValue}) {
    return _prefs.getBool(key) ?? defaultValue;
  }

  /// Saves a double [value] to persistent storage in the background.
  /// Android doesn't support storing doubles, so it will be stored as a float.
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  Future<bool> setDouble({required String key, required double value}) async {
    return await _prefs.setDouble(key, value);
  }

  /// Saves a string [value] to persistent storage in the background.
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  Future<bool> setString({required String key, required String value}) async {
    return await _prefs.setString(key, value);
  }

  /// Saves a list of strings [value] to persistent storage in the background.
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  Future<bool> setStringList(
      {required String key, required List<String> value}) async {
    return await _prefs.setStringList(key, value);
  }

  /// Removes an entry from persistent storage.
  Future<bool> remove({required String key}) async {
    return await _prefs.remove(key);
  }

  /// Reads a value from persistent storage, throwing an exception if it's not
  /// an int.
  int getInt({required String key, required int defaultValue}) {
    return _prefs.getInt(key) ?? defaultValue;
  }

  /// Reads a value from persistent storage, throwing an exception if it's not a double.
  double getDouble({required String key, required double defaultValue}) {
    return _prefs.getDouble(key) ?? defaultValue;
  }

  /// Reads a value from persistent storage, throwing an exception if it's not a String.
  String? getString({required String key, required String? defaultValue}) {
    return _prefs.getString(key) ?? defaultValue;
  }

  /// Reads a set of string values from persistent storage, throwing an exception if it's not a string set.
  List<String> getStringList(
      {required String key, required List<String> defaultValue}) {
    return _prefs.getStringList(key) ?? defaultValue;
  }

  /// Saves a boolean [value] to persistent storage in the background.
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  Future<bool> setBool({required String key, required bool value}) async {
    return await _prefs.setBool(key, value);
  }

  /// Saves an integer [value] to persistent storage in the background.
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  Future<bool> setInt({required String key, required int value}) async {
    return await _prefs.setInt(key, value);
  }
}
