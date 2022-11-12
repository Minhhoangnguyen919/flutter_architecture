import 'base_dimens.dart';

class DimensForgotPasswordView extends BaseDimens {
  double contentHeight = 0.0;
  double contentPaddingHorizontal = 0.0;
  double spaceVertical = 0.0;

  @override
  void initialDimens<MainView>() {
    contentHeight = fullHeightSafeArea - headerTabHeightWidthStatusBar;
    contentPaddingHorizontal = fullWidthSafeArea * 0.05;
    spaceVertical = fullHeightSafeArea * 0.015;
  }
}
