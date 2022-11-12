import 'base_dimens.dart';

class DimensUpdateProfileView extends BaseDimens {
  double paddingVertical = 0.0;
  double paddingHorizontal = 0.0;
  double positionBottomIconImage = 0.0;
  double positionRightIconImage = 0.0;
  double radiusImage = 0.0;
  double paddingIconImage = 0.0;
  double spaceVertical = 0.0;
  double widthMaxButton = 0.0;
  double heightBottomModal = 0.0;
  double paddingContentInBottomModal = 0.0;
  double sizeIconBottomModal = 0.0;
  double sizeIconSuffix = 0.0;

  //Size determination for each screen
  @override
  void initialDimens<UpdateProfileView>() {
    paddingVertical = fullHeightSafeArea * 0.03;
    paddingHorizontal = fullWidthSafeArea * 0.05;
    positionBottomIconImage = fullHeightSafeArea * 0;
    positionRightIconImage = fullWidthSafeArea * 0.005;
    radiusImage = fullWidthSafeArea * 0.12;
    paddingIconImage = fullHeightSafeArea * 0.01;
    spaceVertical = fullHeightSafeArea * 0.02;
    widthMaxButton = fullWidthSafeArea * 1;
    heightBottomModal = fullHeightSafeArea * 0.25;
    paddingContentInBottomModal = fullWidthSafeArea * 0.05;
    sizeIconBottomModal = fullHeightSafeArea * 0.05;
    sizeIconSuffix = fullHeightSafeArea *0.03;
  }
}
