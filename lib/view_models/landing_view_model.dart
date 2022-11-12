import 'package:develop_app_hoangnm/core/utils/log_utils.dart';
import 'package:develop_app_hoangnm/view_models/base_view_model.dart';

import 'package:flutter/cupertino.dart';

class LandingViewModel extends BaseViewModel {
  @override
  void onInitViewModel(BuildContext context) {
    super.onInitViewModel(context);
    LogUtils.d("[$runtimeType][LANDING_VIEW_MODEL] => RUNNING");
  }
}
