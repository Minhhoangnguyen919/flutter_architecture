
import 'base_dimens.dart';

class DimensSearchView extends BaseDimens {
  double footerIconSize = 0;

  //Size determination for each screen
  @override
  void initialDimens<SearchView>() {
    footerIconSize = (footerTabHeight - homeIndicatorHeight) * 0.955;
  }
}
