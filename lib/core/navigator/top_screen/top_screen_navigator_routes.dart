import 'package:develop_app_hoangnm/ui/views/main_view.dart';
import 'package:develop_app_hoangnm/conponent/splash_view/splash_view.dart';
import 'package:develop_app_hoangnm/ui/widgets/banners/flavor_banner.dart';
import 'package:flutter/material.dart';

/// TopScreenNavigator
/// Define route for application (1 route = 1 view).
class TopScreenNavigatorRoutes {
  static const String mainRoute = 'main';
  static const String splashRoute = 'splash';


  static TopScreenNavigatorRoutes? _instance;

  const TopScreenNavigatorRoutes._();

  factory TopScreenNavigatorRoutes() =>
      _instance ??= const TopScreenNavigatorRoutes._();

  void destroyInstance() {
    _instance = null;
  }

  String initialRoute() => splashRoute;

  void openMainView(BuildContext context) {
    Navigator.pushReplacementNamed(context, mainRoute);
  }

  Route<dynamic> routeBuilders(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return _buildViewWithBanner(
          view: const SplashView(),
        );
      case mainRoute:
      default:
        return _buildViewWithBanner(
          view: const MainView(),
        );
    }
  }
}

MaterialPageRoute _buildViewWithBanner({required Widget view}) {
  return MaterialPageRoute<dynamic>(
    builder: (_) => FlavorBanner(
      child: view,
    ),
  );
}
