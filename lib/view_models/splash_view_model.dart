import 'package:develop_app_hoangnm/core/navigator/top_screen/top_screen_navigator_routes.dart';
import 'package:develop_app_hoangnm/view_models/base_view_model.dart';

class SplashViewModel extends BaseViewModel {

  @override
  void onBuildComplete({bool isNeedReBuildByOtherViewModel = true}) {
    super.onBuildComplete();
    _navigatorMainView();
  }

  void _navigatorMainView(){
     Future.delayed(const Duration(seconds: 1), () {
       TopScreenNavigatorRoutes().openMainView(context); // Prints after 1 second.
    });
  }
}