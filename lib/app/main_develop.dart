import 'package:develop_app_hoangnm/application.dart';
import 'package:develop_app_hoangnm/core/enums/enums.dart';
import 'package:develop_app_hoangnm/core/utils/wait_apply_screen_size.dart';
import 'package:develop_app_hoangnm/ui/widgets/banners/flavor_config.dart';
import 'package:flutter/material.dart';


const Flavor flavorName = Flavor.develop;

void main() async {
  await WaitApplyScreenSize().waitScreenSizeAvailable();
  _setUpFlavorDevelop();
  runApp(const Application());
}

void _setUpFlavorDevelop() {
  FlavorConfig(
      flavor: flavorName,
      color: Colors.redAccent,
      baseApiUrl: "",
      versionAPI: "",
      othersVersionApi: {},
      supportMailAddress: "",
      hasMockAPI: true,
  );
}
