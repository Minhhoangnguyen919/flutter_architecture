import 'package:develop_app_hoangnm/core/utils/wait_apply_screen_size.dart';
import 'package:develop_app_hoangnm/ui/widgets/banners/flavor_config.dart';
import 'package:flutter/material.dart';

import 'application.dart';
import 'core/enums/enums.dart';

const Flavor flavorName = Flavor.develop;

void main() async {
  // Wait for calculator size
  await WaitApplyScreenSize().waitScreenSizeAvailable();
  // Setup Flavor
  _setUpFlavorDevelop();
  runApp(const Application());
}

void _setUpFlavorDevelop() {
  FlavorConfig(
      flavor: flavorName,
      color: Colors.redAccent,
      // それ以外のAPIの接続先
      baseApiUrl: "",
      versionAPI: "",
      othersVersionApi: {},
      supportMailAddress: "",
      saveRidingLogApiUrl: "",
      saveRidingLogVersionApi: "",
      hasMockAPI: false,
  );
}
