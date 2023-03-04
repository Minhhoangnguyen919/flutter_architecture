import 'package:develop_app_hoangnm/ui/shared/colors.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_manager.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_splash_view.dart';
import 'package:develop_app_hoangnm/conponent/splash_view/splash_view_model.dart';
import 'package:flutter/material.dart';

import '../base_view/base_view.dart';


class SplashView extends BaseView {
  const SplashView({Key? key}) : super(key: key);

  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends BaseViewState<SplashView,
    SplashViewModel, DimensSplashView> {

  @override
  void createDimens() {
    super.createDimens();
    viewSize = DimensManager().dimensSplashView;
  }

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = SplashViewModel()..onInitViewModel(context);
  }

  @override
  void onBuildCompleted() {
    super.onBuildCompleted();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColors.backgroundColorSplash,
      body: Container(
        alignment: Alignment.center,
        child: Image.asset(
          "assets/images/splashLogo.png",
        ),
      ),
    );
  }

}
