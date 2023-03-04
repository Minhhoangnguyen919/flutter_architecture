import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:develop_app_hoangnm/core/plugin/internet/data_conection_checker.dart';

import 'log_utils.dart';

class NetworkUtils {
  static bool _isConnectToInternet = true;

  static Future<void> connect() async {
    final connectResult = await Connectivity().checkConnectivity();
    switch (connectResult) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.mobile:
      case ConnectivityResult.vpn:
      case ConnectivityResult.bluetooth:
        _isConnectToInternet = await DataConnectionChecker().hasConnection;
        break;
      case ConnectivityResult.none:
        _isConnectToInternet = false;
        break;
    }
  }

  static bool hasConnection() {
    LogUtils.d("[has internet -> $_isConnectToInternet");
    return _isConnectToInternet;
  }

  static Stream<ConnectivityResult> connectionListener() {
    return Connectivity().onConnectivityChanged;
  }
}
