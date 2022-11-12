import 'base_dimens.dart';

class DimensUserView extends BaseDimens {
  double footerIconSize = 0;

  //Size determination for each screen
  @override
  void initialDimens<UserView>() {
    footerIconSize = (footerTabHeight - homeIndicatorHeight) * 0.955;
  }
}
