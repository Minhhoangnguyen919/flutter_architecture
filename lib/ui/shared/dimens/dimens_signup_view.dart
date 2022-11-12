import 'package:develop_app_hoangnm/ui/shared/dimens/base_dimens.dart';

class DimensSignUpView extends BaseDimens {
  double contentHeight = 0.0;
  double contentPaddingHorizontal = 0.0;
  double spaceVertical = 0.0;
  double checkBoxLabelFontSize = 0.0;
  double buttonLoginWidth = 0.0;
  double buttonLoginHeight = 0.0;

  @override
  void initialDimens<T>() {
    contentHeight = fullHeightSafeArea - headerTabHeightWidthStatusBar;
    contentPaddingHorizontal = fullWidthSafeArea * 0.05;
    spaceVertical = fullHeightSafeArea * 0.015;
    checkBoxLabelFontSize = fullHeightSafeArea * 0.0225;
    buttonLoginHeight = fullHeightSafeArea * 0.08;
    buttonLoginWidth = fullWidthSafeArea * 0.75;
  }
}
