import 'base_dimens.dart';

class DimensCourseDetailView extends BaseDimens {
  double contentHeight = 0.0;
  double contentPaddingHorizontal = 0.0;
  double spaceVertical = 0.0;
  double spaceHorizontal = 0.0;
  double avatarRadius = 0.0;
  double buttonHeight = 0.0;
  double buttonWidth = 0.0;
  double reviewSize = 0.0;

  @override
  void initialDimens<MainView>() {
    contentHeight = fullHeightSafeArea - headerTabHeightWidthStatusBar;
    contentPaddingHorizontal = fullWidthSafeArea * 0.05;
    spaceVertical = fullHeightSafeArea * 0.0078;
    spaceHorizontal = fullWidthSafeArea * 0.03;
    avatarRadius = fullWidth * 0.06;
    buttonHeight = fullHeightSafeArea * 0.04;
    buttonWidth = fullWidth * 0.438;
    reviewSize = fullWidth * 0.054;
  }
}
