import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_search.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_home_view.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_shopping_bag_view.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_splash_view.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_user_view.dart';
import 'package:develop_app_hoangnm/conponent/bottom_bar_view/home_view/home_view.dart';
import 'package:develop_app_hoangnm/conponent/bottom_bar_view/search_view/search_view.dart';
import 'package:develop_app_hoangnm/conponent/bottom_bar_view/shopping_bag_view/shopping_bag_view.dart';
import 'package:develop_app_hoangnm/conponent/user_view/user_view.dart';
import 'package:develop_app_hoangnm/ui/views/main_view.dart';
import 'package:develop_app_hoangnm/conponent/splash_view/splash_view.dart';
import 'package:flutter/cupertino.dart';
import 'dimens_main_view.dart';

/// Manage size view
class DimensManager {
  ///
  late DimensMainView _dimensMainView;

  DimensMainView get mainViewSize => _dimensMainView;

  late DimensSplashView _dimensSplashView;

  DimensSplashView get dimensSplashView => _dimensSplashView;

  late DimensHomeView _dimensHomeView;

  DimensHomeView get dimensHomeView => _dimensHomeView;

  late DimensSearchView _dimensSearchView;

  DimensSearchView get dimensSearchView => _dimensSearchView;

  late DimensShoppingBagView _dimensShoppingBagView;

  DimensShoppingBagView get dimensShoppingBagView => _dimensShoppingBagView;

  late DimensUserView _dimensUserView;

  DimensUserView get dimensUserView => _dimensUserView;

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
    _dimensUserView = DimensUserView();
    _dimensShoppingBagView = DimensShoppingBagView();
    _dimensHomeView = DimensHomeView();
    _dimensSearchView = DimensSearchView();

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
      case HomeView:
        _dimensHomeView.calculatorRatio<T>(context);
        break;
      case SearchView:
        _dimensSearchView.calculatorRatio<T>(context);
        break;
      case ShoppingBagView:
        _dimensShoppingBagView.calculatorRatio<T>(context);
        break;
      case UserView:
        _dimensUserView.calculatorRatio<T>(context);
        break;
      default:
        // TODO: Handle later
        break;

      ///Add
    }
  }
}
