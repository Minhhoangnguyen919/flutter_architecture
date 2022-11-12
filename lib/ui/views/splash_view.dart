import 'package:develop_app_hoangnm/ui/shared/colors.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_change_password_view.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_manager.dart';
import 'package:develop_app_hoangnm/view_models/splash_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'base_view.dart';


class SplashView extends BaseView {
  const SplashView({Key? key}) : super(key: key);

  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends BaseViewState<SplashView,
    SplashViewModel, DimensChangePasswordView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void createDimens() {
    super.createDimens();
    viewSize = DimensManager().changePasswordViewSize;
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
      key: _scaffoldKey,
      backgroundColor: HexColors.white,
      body: Container(),
    );
  }

}
