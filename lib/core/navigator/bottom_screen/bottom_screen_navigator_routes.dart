import 'package:develop_app_hoangnm/core/enums/enums.dart';
import 'package:develop_app_hoangnm/conponent/bottom_bar_view/home_view/home_view.dart';
import 'package:develop_app_hoangnm/conponent/bottom_bar_view/search_view/search_view.dart';
import 'package:develop_app_hoangnm/conponent/bottom_bar_view/shopping_bag_view/shopping_bag_view.dart';
import 'package:develop_app_hoangnm/conponent/user_view/user_view.dart';
import 'package:flutter/material.dart';


class BottomScreenNavigatorRoutes {
  static const Map<BottomTabItem, String> _routes = {
    BottomTabItem.homeView: "Home_router",
    BottomTabItem.bagView: "Bag_router",
    BottomTabItem.searchView: "Search_router",
    BottomTabItem.userView: "User_router",
  };

  static BottomScreenNavigatorRoutes? _instance;

  BottomScreenNavigatorRoutes._();

  factory BottomScreenNavigatorRoutes() =>
      _instance ??= BottomScreenNavigatorRoutes._();

  void destroyInstance() {
    _instance = null;
  }

  String initialRoute() => _routes[BottomTabItem.homeView]!;

  Map<String, Widget Function(BuildContext)> routeBuilders(
      BuildContext context) {
    return {
      _routes[BottomTabItem.homeView]!: (context) => const HomeView(),
      _routes[BottomTabItem.bagView]!: (context) => const ShoppingBagView(),
      _routes[BottomTabItem.searchView]!: (context) => const SearchView(),
      _routes[BottomTabItem.userView]!: (context) => const UserView(),
    };
  }

  /// Get Route name with bottom tab item
  String routeName(BottomTabItem tabItem) {
    return _routes[tabItem]!;
  }

}
