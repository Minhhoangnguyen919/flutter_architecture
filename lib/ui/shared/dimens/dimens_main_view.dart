import 'base_dimens.dart';

class DimensMainView extends BaseDimens {
  double footerIconSize = 0;

  //Size determination for each screen
  @override
  void initialDimens<MainView>() {
    footerIconSize = (footerTabHeight - homeIndicatorHeight) * 0.45;
  }
}
