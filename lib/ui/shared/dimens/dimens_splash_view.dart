import 'base_dimens.dart';

class DimensSplashView extends BaseDimens {
  double footerIconSize = 0;

  //Size determination for each screen
  @override
  void initialDimens<SplashView>() {
    footerIconSize = (footerTabHeight - homeIndicatorHeight) * 0.955;
  }
}
