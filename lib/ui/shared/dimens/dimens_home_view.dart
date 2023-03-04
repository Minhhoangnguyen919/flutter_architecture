import 'base_dimens.dart';

class DimensHomeView extends BaseDimens {
  double footerIconSize = 0;

  //Size determination for each screen
  @override
  void initialDimens<HomeView>() {
    footerIconSize = (footerTabHeight - homeIndicatorHeight) * 0.955;
  }
}
