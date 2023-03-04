import 'dart:convert';

import 'package:develop_app_hoangnm/core/utils/log_utils.dart';

class QRCodeModel {
  static QRCodeModel? _instance;


  String? get urlJsonQrCode {
    return '{"id": "0000000001","name": "Hoangnm","token": "sshjsksaloakm"}';
  }

  /// Constructor
  QRCodeModel._();

  factory QRCodeModel() {
    return _instance ??= QRCodeModel._();
  }

  void destroyInstance() {
    _instance = null;
  }

  void updateFriendTokenData(String? data) {
    LogUtils.d("[UPDATE QR TOKEN] $data");
  }

  String? getUserNameFromJson(String json) {
    try {
      Map<String, dynamic> decodeResult =
      jsonDecode(json) as Map<String, dynamic>;
      return QrCodeJson.fromJson(decodeResult).name;
    } on Exception {
      return null;
    }
  }

  String? getCustomerIdFromJson(String json) {
    try {
      Map<String, dynamic> decodeResult =
      jsonDecode(json) as Map<String, dynamic>;
      return QrCodeJson.fromJson(decodeResult).id;
    } on Exception {
      return null;
    }
  }
}

class QrCodeJson {
  QrCodeJson({
    this.id,
    this.name,
    this.token,
  });

  final String? id;
  final String? name;
  final String? token;

  factory QrCodeJson.fromJson(Map<String, dynamic> json) =>
      QrCodeJson(
        id: json["id"] as String,
        name: json["name"] as String,
        token: json["token"] as String,
      );

  static dynamic responseDummy() {
    return {
      "id": "0000000001",
      "name": "Hoangnm",
      "token": "sshjsksaloakm"
    };
  }
}

