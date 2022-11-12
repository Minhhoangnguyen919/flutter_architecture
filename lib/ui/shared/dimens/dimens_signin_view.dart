import 'package:develop_app_hoangnm/ui/shared/dimens/base_dimens.dart';

class DimensSignInView extends BaseDimens {
  double contentHeight = 0.0;
  double contentPaddingHorizontal = 0.0;
  double loginIconLogoSize = 0.0;
  double textFieldHeight = 0.0;
  double textFieldFontSize = 0.0;
  double contentPaddingTextFieldHorizontal = 0.0;
  double spaceVertical = 0.0;
  double spaceVerticalPaddingContent = 0.0;
  double checkBoxLabelFontSize = 0.0;
  double buttonLoginWidth = 0.0;
  double buttonLoginHeight = 0.0;
  double buttonLoginFontSize = 0.0;

  @override
  void initialDimens<SignInView>() {
    contentHeight = fullHeightSafeArea - headerTabHeightWidthStatusBar;
    contentPaddingHorizontal = fullWidthSafeArea * 0.05;
    loginIconLogoSize = fullHeightSafeArea * 0.2;
    textFieldHeight = fullHeightSafeArea * 0.07;
    textFieldFontSize = fullHeightSafeArea * 0.026;
    contentPaddingTextFieldHorizontal = fullWidthSafeArea * 0.035;
    spaceVertical = fullHeightSafeArea * 0.015;
    spaceVerticalPaddingContent = fullHeightSafeArea * 0.065;
    checkBoxLabelFontSize = fullHeightSafeArea * 0.0225;
    buttonLoginHeight = fullHeightSafeArea * 0.08;
    buttonLoginWidth = fullWidthSafeArea * 0.75;
    buttonLoginFontSize = buttonLoginHeight * 0.35;
  }
}
