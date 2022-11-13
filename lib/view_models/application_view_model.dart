import 'package:develop_app_hoangnm/core/navigator/top_screen/top_screen_navigator_routes.dart';
import 'package:develop_app_hoangnm/core/utils/info_utils.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_manager.dart';
import 'package:develop_app_hoangnm/conponent/base_view/base_view_model.dart';

class ApplicationViewModel extends BaseViewModel {
  Future<void> destroySingletonObject() async {
    _destroyRouteInstance();
    // SharedPreference
    _destroySharedPreferenceInstance();
    // Dimens
    _destroyDimensInstance();
    // InfoUtils
    _destroyInfoUtils();
  }

  void _destroyRouteInstance() {
    TopScreenNavigatorRoutes().destroyInstance();
  }

  void _destroySharedPreferenceInstance() {
    // TODO(後で処理する)
  }

  void _destroyDimensInstance() {
    DimensManager().destroyInstance();
  }

  void _destroyInfoUtils() {
    InfoUtils().destroyInstance();
  }
}
