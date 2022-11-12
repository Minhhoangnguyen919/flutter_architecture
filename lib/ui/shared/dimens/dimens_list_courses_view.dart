import 'package:develop_app_hoangnm/ui/shared/dimens/base_dimens.dart';

class DimensListCoursesView extends BaseDimens {
  double separatorListView = 0.0;
  double spaceItemListView = 0.0;
  double contentPaddingVertical = 0.0;
  double contentPaddingHorizontal = 0.0;
  double elevationCircular = 0.0;
  double ivWidthCourses = 0.0;
  double ivHeightCourses = 0.0;
  double borderRadiusSearch = 0.0;

  @override
  void initialDimens<ListCoursesView>() {
    super.initialDimens();
    // separatorListView with scale is 2dp
    separatorListView = fullHeightSafeArea * 0.00129;
    // spaceItemListView with scale is 10dp
    spaceItemListView = fullHeightSafeArea * 0.0129;
    // contentPaddingVertical with scale is 16dp
    contentPaddingVertical = fullHeightSafeArea * 0.021;
    // paddingHorizontalList with scale is 20dp
    contentPaddingHorizontal = fullWidthSafeArea * 0.05;
    // elevationCircular with scale is 15dp
    elevationCircular = (fullHeightSafeArea + fullWidthSafeArea) * 0.0127;
    // ivWidthCourses with scale is 80dp
    ivWidthCourses = fullWidthSafeArea * 0.195;
    // ivHeightCourses with scale is 90dp
    ivHeightCourses = fullHeightSafeArea * 0.12;
    // borderRadiusSearch with scale is 100dp
    borderRadiusSearch = fullHeightSafeArea * 0.243;
  }
}
