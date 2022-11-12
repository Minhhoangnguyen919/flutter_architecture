import 'base_dimens.dart';

class DimensChangePasswordView extends BaseDimens {
  double contentPaddingHorizontal = 0.0;
  double spaceVertical = 0.0;
  double spaceVerticalPaddingContent = 0.0;

  @override
  void initialDimens<ChangePasswordView>() {
    // The equivalent ratio of content padding is 16 dp
    contentPaddingHorizontal = fullWidthSafeArea * 0.04;
    // The equivalent ratio of space vertical is 16 dp
    spaceVertical = fullHeightSafeArea * 0.021;
    // The equivalent ratio of space vertical padding content is 25 dp
    spaceVerticalPaddingContent = fullHeightSafeArea * 0.06;
  }
}