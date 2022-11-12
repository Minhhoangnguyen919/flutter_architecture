
import 'package:develop_app_hoangnm/core/enums/enums.dart';
import 'package:develop_app_hoangnm/core/utils/log_utils.dart';
import 'package:develop_app_hoangnm/ui/shared/colors.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_main_view.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_manager.dart';
import 'package:develop_app_hoangnm/ui/views/base_view.dart';
import 'package:develop_app_hoangnm/ui/widgets/bottom_navigation/bottom_navigation_widget.dart';
import 'package:develop_app_hoangnm/view_models/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MainView extends BaseView {
  const MainView({Key? key}) : super(key: key);

  @override
  MainViewState createState() => MainViewState();
}

class MainViewState
    extends BaseViewState<MainView, MainViewModel, DimensMainView> {
  @override
  void createDimens() {
    super.createDimens();
    viewSize = DimensManager().mainViewSize;
  }

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = MainViewModel()..onInitViewModel(context);
  }

  @override
  void calculatorSizeForOtherWidget() {
    viewSize.calculatorRatio<MainView>(context);
  }


  final Map<BottomTabItem, Widget?> _cacheBottomTabWidgets = {
    BottomTabItem.homeView: null,
    BottomTabItem.bagView: null,
    BottomTabItem.searchView: null,
    BottomTabItem.userView: null,
  };

  final Map<BottomTabItem, GlobalKey<NavigatorState>> _bottomTabKeys = {
    BottomTabItem.homeView: GlobalKey<NavigatorState>(),
    BottomTabItem.bagView: GlobalKey<NavigatorState>(),
    BottomTabItem.searchView: GlobalKey<NavigatorState>(),
    BottomTabItem.userView: GlobalKey<NavigatorState>(),
  };

  @override
  Widget buildView(BuildContext context) {
    return Selector<MainViewModel, BottomTabItem>(
      builder: (_, currentBottomTab, __) {
        return Scaffold(
          backgroundColor: HexColors.white,
          body: Stack(
            children: [
              _buildTabItem(
                BottomTabItem.homeView,
                _cacheBottomTabWidgets[BottomTabItem.homeView],
              ),
              _buildTabItem(
                BottomTabItem.bagView,
                _cacheBottomTabWidgets[BottomTabItem.bagView],
              ),
              _buildTabItem(
                BottomTabItem.searchView,
                _cacheBottomTabWidgets[BottomTabItem.searchView],
              ),
              _buildTabItem(
                BottomTabItem.userView,
                _cacheBottomTabWidgets[BottomTabItem.userView],
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationWidget(
            currentTab: currentBottomTab,
            onItemBottomNavigationSelect: (tabItem) =>
                _onItemBottomNavigationSelect(tabItem),
            onItemBottomNavigationMoveBack: () =>
                _onItemBottomNavigationMoveBack(),
            onItemBottomNavigationMoveNext: () =>
                _onItemBottomNavigationMoveNext(),
          ),
        );
      },
      selector: (_, viewModel) => viewModel.currentBottomTab,
    );
  }

  Widget _buildTabItem(BottomTabItem tabItem, Widget? child) {
    // Cache Widget
    return Offstage(
      offstage: viewModel.currentBottomTab != tabItem,
      child: child ??
          (viewModel.currentBottomTab == tabItem
              ? _buildCacheTab(tabItem)
              : Container()),
    );
  }

  void _onItemBottomNavigationMoveNext() {
    int indexCurrentBottomTab =
    BottomTabItem.values.indexOf(viewModel.currentBottomTab);
    if (indexCurrentBottomTab != (BottomTabItem.values.length - 1)) {
      viewModel.changeTab(BottomTabItem.values[indexCurrentBottomTab + 1]);
    }
  }
  Widget _buildCacheTab(BottomTabItem tabItem) {
    return _cacheBottomTabWidgets[tabItem] = BottomBodyNavigationWidget(
      tabItem: tabItem,
      navigatorKey: _bottomTabKeys[tabItem]!,
    );
  }

  void _onItemBottomNavigationMoveBack() {
    int indexCurrentBottomTab =
    BottomTabItem.values.indexOf(viewModel.currentBottomTab);
    if (indexCurrentBottomTab != 0) {
      viewModel.changeTab(BottomTabItem.values[indexCurrentBottomTab - 1]);
    }
  }

  void _onItemBottomNavigationSelect(BottomTabItem tabItem) {
    LogUtils.i("($tabItem)");
    if (viewModel.currentBottomTab != tabItem) {
      viewModel.changeTab(tabItem);
    }
  }
}
