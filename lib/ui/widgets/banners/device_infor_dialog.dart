import 'dart:io';

import 'package:develop_app_hoangnm/core/enums/enums.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

import 'flavor_config.dart';

class DeviceInfoDialog extends StatelessWidget {
  const DeviceInfoDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.only(bottom: 10.0),
      title: Container(
        padding: const EdgeInsets.all(15.0),
        color: FlavorConfig.instance!.color,
        child: const Text(
          'Information Device:',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      titlePadding: const EdgeInsets.all(0),
      content: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (Platform.isAndroid) {
      return _buildAndroidContent(context);
    }

    if (Platform.isIOS) {
      return _buildIOSContent(context);
    }

    return const Text("You're not on Android neither iOS");
  }

  Widget _buildIOSContent(BuildContext context) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: _iosDeviceInfo(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          final device = snapshot.data as IosDeviceInfo;
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildTile('Flavor:', FlavorConfig.instance!.name),
                _buildTile('Build mode:', _currentBuildMode().toString()),
                _buildTile('Physical device?:', '${device.isPhysicalDevice}'),
                _buildTile('Device:', device.name ?? ""),
                _buildTile('Model:', device.model ?? ""),
                _buildTile('System name:', device.systemName ?? ""),
                _buildTile('System version:', device.systemVersion ?? ""),
                _buildTile('Width:', '$width'),
                _buildTile('Height:', '$height'),
                _buildTile('PixelRatio:', '$devicePixelRatio'),
              ],
            ),
          );
        });
  }

  Widget _buildAndroidContent(BuildContext context) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: _androidDeviceInfo(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          final device = snapshot.data as AndroidDeviceInfo;
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildTile('Flavor:', FlavorConfig.instance!.name),
                _buildTile('Build mode:', _currentBuildMode().toString()),
                _buildTile('Physical device?:', '${device.isPhysicalDevice}'),
                _buildTile('Manufacturer:', device.manufacturer ?? ""),
                _buildTile('Model:', device.model ?? ""),
                _buildTile('Android version:', device.version.release ?? ""),
                _buildTile('Android SDK:', '${device.version.sdkInt}'),
                _buildTile('Width:', '$width'),
                _buildTile('Height:', '$height'),
                _buildTile('PixelRatio:', '$devicePixelRatio'),
              ],
            ),
          );
        });
  }

  Widget _buildTile(String key, String value) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          Text(
            key,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value)
        ],
      ),
    );
  }

  BuildMode _currentBuildMode() {
    if (const bool.fromEnvironment('dart.vm.product')) {
      return BuildMode.release;
    }
    var result = BuildMode.profile;

    //Little trick, since assert only runs on DEBUG mode
    assert(() {
      result = BuildMode.debug;
      return true;
    }());
    return result;
  }

  Future<AndroidDeviceInfo> _androidDeviceInfo() {
    final plugin = DeviceInfoPlugin();
    return plugin.androidInfo;
  }

  Future<IosDeviceInfo> _iosDeviceInfo() {
    final plugin = DeviceInfoPlugin();
    return plugin.iosInfo;
  }
}
