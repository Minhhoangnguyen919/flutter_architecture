import 'package:develop_app_hoangnm/core/enums/enums.dart';
import 'package:flutter/material.dart';

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final Color color;
  final String baseApiUrl;
  final String versionApi;
  final Map<String, String>? othersVersionApi;
  /// 走行ログ保存APIのみ別のサーバー
  final String saveRidingLogApiUrl;
  final String saveRidingLogVersionApi;
  final String supportMailAddress;
  final bool hasMockAPI; // use http_mock_adapter

  static FlavorConfig? _instance;

  const FlavorConfig._({
    required this.flavor,
    required this.name,
    required this.color,
    required this.baseApiUrl,
    required this.versionApi,
    this.othersVersionApi,
    required this.supportMailAddress,
    required this.saveRidingLogApiUrl,
    required this.saveRidingLogVersionApi,
    required this.hasMockAPI,
  });

  factory FlavorConfig({
    required Flavor flavor,
    Color color = Colors.blue,
    required String baseApiUrl,
    required String versionAPI,
    Map<String, String>? othersVersionApi,
    required String supportMailAddress,
    required String saveRidingLogApiUrl,
    required String saveRidingLogVersionApi,
    required bool hasMockAPI,
  }) {
    return _instance ??= FlavorConfig._(
      flavor: flavor,
      name: flavor.toString().split('.').last,
      color: color,
      baseApiUrl: baseApiUrl,
      versionApi: versionAPI,
      othersVersionApi: othersVersionApi,
      supportMailAddress: supportMailAddress,
      saveRidingLogApiUrl: saveRidingLogApiUrl,
      saveRidingLogVersionApi: saveRidingLogVersionApi,
      hasMockAPI: hasMockAPI,
    );
  }

  static FlavorConfig? get instance => _instance;

  static bool isProduction() => _instance?.flavor == Flavor.production;

  static bool isDevelopment() => _instance?.flavor == Flavor.develop;
}