import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_manager.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_splash_view.dart';
import 'package:develop_app_hoangnm/ui/views/base_view.dart';
import 'package:develop_app_hoangnm/view_models/home_view_model.dart';
import 'package:flutter/material.dart';


class HomeView extends BaseView {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends BaseViewState<HomeView,
    HomeViewModel, DimensSplashView> {

  @override
  void createDimens() {
    super.createDimens();
    viewSize = DimensManager().dimensSplashView;
  }

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = HomeViewModel()..onInitViewModel(context);
  }

  @override
  Widget buildView(BuildContext context) {
    return const SafeArea(
      child: Text("home"),
    );
  }

}
