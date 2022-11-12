import 'package:develop_app_hoangnm/core/utils/wait_apply_screen_size.dart';
import 'package:flavor_config/flavor_config.dart';
import 'package:flutter/material.dart';

import 'application.dart';
import 'core/enums/enums.dart';

const Flavor flavorName = Flavor.production;

void main() async {
  // Wait for calculator size
  await WaitApplyScreenSize().waitScreenSizeAvailable();
  // Setup Flavor
  _setUpFlavorProduct();
  runApp(const Application());
}

void _setUpFlavorProduct() {
  FlavorConfig(
    flavorName: '',
    values: {},
  );
}
