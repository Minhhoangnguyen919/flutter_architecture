import 'package:flutter/material.dart';

import 'device_infor_dialog.dart';
import 'flavor_config.dart';

class FlavorBanner extends StatelessWidget {
  final Widget child;
  const FlavorBanner({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (FlavorConfig.isProduction()) return child;

    final bannerConfig = _getDefaultBanner();

    return Stack(
      children: <Widget>[child, _buildBanner(context, bannerConfig)],
    );
  }

  BannerConfig _getDefaultBanner() {
    return BannerConfig(
      bannerName: FlavorConfig.instance!.name,
      bannerColor: FlavorConfig.instance!.color,
    );
  }

  Widget _buildBanner(BuildContext context, BannerConfig bannerConfig) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
        width: 50,
        height: 50,
        child: CustomPaint(
          painter: BannerPainter(
            message: bannerConfig.bannerName,
            textDirection: Directionality.of(context),
            layoutDirection: Directionality.of(context),
            location: BannerLocation.topStart,
            color: bannerConfig.bannerColor,
          ),
        ),
      ),
      onLongPress: () {
        showDialog<void>(
          context: context,
          builder: (context) {
            return const DeviceInfoDialog();
          },
        );
      },
    );
  }
}

class BannerConfig {
  final String bannerName;
  final Color bannerColor;

  const BannerConfig({required this.bannerName, required this.bannerColor});
}
