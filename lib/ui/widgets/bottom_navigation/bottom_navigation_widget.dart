import 'package:develop_app_hoangnm/core/enums/enums.dart';
import 'package:develop_app_hoangnm/core/navigator/bottom_screen/bottom_screen_navigator_routes.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_manager.dart';
import 'package:develop_app_hoangnm/ui/shared/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigationWidget extends StatelessWidget {
  static const Map<BottomTabItem, String> tabIcon = {
    BottomTabItem.homeView: Images.iconHome,
    BottomTabItem.bagView: Images.iconShopBag,
    BottomTabItem.searchView: Images.iconSearch,
    BottomTabItem.userView: Images.iconUser,
  };

  final Map<BottomTabItem, String> tabIconActive = {
    BottomTabItem.homeView: Images.iconHomeActive,
    BottomTabItem.bagView: Images.iconShopBagActive,
    BottomTabItem.searchView: Images.iconSearchActive,
    BottomTabItem.userView: Images.iconUserActive,
  };

  final BottomTabItem currentTab;
  final ValueChanged<BottomTabItem> onItemBottomNavigationSelect;
  final Function onItemBottomNavigationMoveBack;
  final Function onItemBottomNavigationMoveNext;

  BottomNavigationWidget({
    required this.currentTab,
    required this.onItemBottomNavigationSelect,
    required this.onItemBottomNavigationMoveBack,
    required this.onItemBottomNavigationMoveNext,
    Key? key
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          // left
          onItemBottomNavigationMoveBack();
        } else if (details.primaryVelocity! < 0) {
          // right
          onItemBottomNavigationMoveNext();
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.blue
        ),
        height: DimensManager().mainViewSize.footerTabHeight,
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            _buildBottomTabItem(BottomTabItem.homeView),
            _buildBottomTabItem(BottomTabItem.bagView),
            _buildBottomTabItem(BottomTabItem.searchView),
            _buildBottomTabItem(BottomTabItem.userView),
          ],
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          onTap: (index) {
            onItemBottomNavigationSelect(BottomTabItem.values[index]);
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomTabItem(BottomTabItem item) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        currentTab != item ? tabIcon[item]! : tabIconActive[item]!,
        fit: BoxFit.contain,
        width: DimensManager().mainViewSize.footerIconSize,
        height: DimensManager().mainViewSize.footerIconSize,
      ),
      label: item.toString(),
    );
  }
}

class BottomBodyNavigationWidget extends StatelessWidget {
  BottomBodyNavigationWidget(
      {required this.tabItem, required this.navigatorKey, Key? key}) : super(key: key);

  final BottomTabItem tabItem;
  final GlobalKey<NavigatorState> navigatorKey;
  final BottomScreenNavigatorRoutes _navigatorRoutes = BottomScreenNavigatorRoutes();

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _navigatorRoutes.routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: _navigatorRoutes.initialRoute(),
      onGenerateRoute: (routeSettings) {
        return PageRouteBuilder<dynamic>(
          pageBuilder: (_, __, ___) =>
              routeBuilders[_navigatorRoutes.routeName(tabItem)]!(context),
          transitionDuration: Duration.zero,
        );
      },
    );
  }
}
