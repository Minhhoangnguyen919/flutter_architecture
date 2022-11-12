import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_splash_view.dart';
import 'package:develop_app_hoangnm/ui/views/main_view.dart';
import 'package:develop_app_hoangnm/ui/views/splash_view.dart';
import 'package:flutter/cupertino.dart';
import 'dimens_main_view.dart';

/// Manage size view
class DimensManager {
  ///
  late DimensMainView _dimensMainView;

  DimensMainView get mainViewSize => _dimensMainView;

  late DimensSplashView _dimensSplashView;

  DimensSplashView get dimensSplashView => _dimensSplashView;

  static DimensManager? _instance;

  factory DimensManager() {
    return _instance ??= DimensManager._();
  }

  /// Constructor
  DimensManager._() {
    _calculatorLanguage();
    _initializeDimens();
  }

  void destroyInstance() {
    //インスタンス破棄
    _instance = null;
  }

  //TODO:
  void _calculatorLanguage() {
    //TODO: Locale myLocale = Localizations.localeOf(context);
  }

  void _initializeDimens() {
    /// [BEGIN] Screen Size
    // MainView
    _dimensMainView = DimensMainView();
    _dimensSplashView = DimensSplashView();

    /// [END] Widget Size
    /// TODO: Add more
  }

  void calculatorRatio<T>(BuildContext context) {
    switch (T) {
      case MainView:
        _dimensMainView.calculatorRatio<T>(context);
        break;
      case SplashView:
        _dimensSplashView.calculatorRatio<T>(context);
        break;
      default:
        // TODO: Handle later
        break;

      ///Add
    }
  }
}
