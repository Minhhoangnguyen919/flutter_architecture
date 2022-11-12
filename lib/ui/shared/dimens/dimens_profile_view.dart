import 'base_dimens.dart';

class DimensProfileView extends BaseDimens {
  double paddingVertical = 0.0;
  double paddingHorizontal = 0.0;
  double positionBottomIconImage = 0.0;
  double radiusImage = 0.0;
  double paddingIconImage = 0.0;
  double paddingBottomDisplayProfile = 0.0;
  double spaceVerticalDisplayProfile = 0.0;
  double spaceVerticalInCenter = 0.0;
  double widthMaxButton = 0.0;
  double spaceVertical = 0.0;

  //Size determination for each screen
  @override
  void initialDimens<T>() {
    paddingVertical = fullHeightSafeArea * 0.03;
    paddingHorizontal = fullWidthSafeArea * 0.05;
    positionBottomIconImage = fullHeightSafeArea * 0;
    radiusImage = fullWidthSafeArea * 0.12;
    paddingIconImage = fullHeightSafeArea * 0.01;
    paddingBottomDisplayProfile = fullHeightSafeArea * 0.03;
    spaceVerticalDisplayProfile = fullHeightSafeArea * 0.005;
    spaceVerticalInCenter = fullHeightSafeArea * 0.02;
    widthMaxButton = fullWidthSafeArea * 1;
    spaceVertical = fullHeightSafeArea * 0.01;
  }
}
