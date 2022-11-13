import 'package:develop_app_hoangnm/ui/views/main_view.dart';
import 'package:develop_app_hoangnm/conponent/splash_view/splash_view.dart';
import 'package:develop_app_hoangnm/ui/widgets/banners/flavor_banner.dart';
import 'package:flutter/material.dart';

/// TopScreenNavigator
/// 1画面で完結する画面の画面遷移を管理
/// Define route for application (1 route = 1 view).
class TopScreenNavigatorRoutes {
  static const String mainRoute = 'main';
  static const String splashRoute = 'splash';
  static const String signInRoute = 'signIn';
  static const String signUpRoute = 'signUp';
  static const String forgotPasswordRoute = 'forgot_password';
  static const String changePasswordRoute = 'change_password';
  static const String landingRoute = 'landing_view';
  static const String coursesRoute = 'courses_view';

  static TopScreenNavigatorRoutes? _instance;

  const TopScreenNavigatorRoutes._();

  factory TopScreenNavigatorRoutes() =>
      _instance ??= const TopScreenNavigatorRoutes._();

  void destroyInstance() {
    //インスタンス破棄
    _instance = null;
  }

  String initialRoute() => splashRoute;

  void openMainView(BuildContext context) {
    Navigator.pushReplacementNamed(context, mainRoute);
  }

  void openSignInView(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, signInRoute, (route) => false);
  }

  void openSignUpView(BuildContext context) {
    Navigator.pushNamed(context, signUpRoute);
  }

  void openForgotPasswordView(BuildContext context) {
    Navigator.pushNamed(context, forgotPasswordRoute);
  }

  void openLandingView(BuildContext context) {
    Navigator.pushNamed(context, landingRoute);
  }

  void openCoursesView(BuildContext context) {
    Navigator.pushNamed(context, coursesRoute);
  }

  void openChangePasswordView(BuildContext context) {
    Navigator.pushNamed(context, changePasswordRoute);
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
