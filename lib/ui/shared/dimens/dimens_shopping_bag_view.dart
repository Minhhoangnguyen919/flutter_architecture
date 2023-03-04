import 'base_dimens.dart';

class DimensShoppingBagView extends BaseDimens {
  double footerIconSize = 0;

  //Size determination for each screen
  @override
  void initialDimens<ShoppingBagView>() {
    footerIconSize = (footerTabHeight - homeIndicatorHeight) * 0.955;
  }
}
