
import 'package:develop_app_hoangnm/ui/shared/app_button.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_main_view.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_manager.dart';
import 'package:develop_app_hoangnm/ui/views/base_view.dart';
import 'package:develop_app_hoangnm/ui/views/splash_view.dart';
import 'package:develop_app_hoangnm/view_models/main_view_model.dart';
import 'package:flutter/material.dart';


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

  double maxHeight = 0.0;

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AppButton(
            label: "Login",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const SplashView();
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}
