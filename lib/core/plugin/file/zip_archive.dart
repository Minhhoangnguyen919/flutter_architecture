import 'dart:async';

import 'package:develop_app_hoangnm/core/utils/log_utils.dart';
import 'package:flutter/services.dart';

class ZipArchie {
  static const MethodChannel _channel = MethodChannel('ZIP_CHANNEL');

  static ZipArchie? _instance;

  const ZipArchie._();

  factory ZipArchie() => _instance ??= const ZipArchie._();

  void destroyInstance() {
    _instance = null;
  }

  Future<bool?> zip(List<String> src, String dest,
      {String? withPassword}) async {
    LogUtils.d("[ZIP_FILE] Zipping ...");
    return await _channel.invokeMethod(
      'zip',
      <String, dynamic>{
        'src': src,
        'dest': dest,
        'pass': withPassword,
      },
    );
  }

  Future<bool?> unzip(String zipSrc, String dest, String pass) async {
    LogUtils.d("[UNZIP_FILE] Unzipping ...");
    return await _channel.invokeMethod(
      'unzip',
      <String, dynamic>{
        'zipSrc': zipSrc,
        'dest': dest,
        'pass': pass,
      },
    );
  }
}
