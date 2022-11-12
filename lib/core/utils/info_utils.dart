import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class InfoUtils {
  static InfoUtils? _instance;
  PackageInfo? _packageInfo;
  AndroidDeviceInfo? _androidDeviceInfo;
  IosDeviceInfo? _iosDeviceInfo;

  PackageInfo get packageInfo => _packageInfo!;

  InfoUtils._();

  factory InfoUtils() {
    return _instance ??= InfoUtils._();
  }

  Future<void> onInit() async {
    _packageInfo = await PackageInfo.fromPlatform();
    if (Platform.isIOS) {
      _iosDeviceInfo = await DeviceInfoPlugin().iosInfo;
    } else {
      _androidDeviceInfo = await DeviceInfoPlugin().androidInfo;
    }
  }

  String get osVersion =>
      _androidDeviceInfo?.version.sdkInt.toString() ??
      _iosDeviceInfo?.systemVersion ??
      "";

  void destroyInstance() {
    //インスタンス破棄
    _instance = null;
  }
}
