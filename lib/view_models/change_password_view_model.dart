import 'package:develop_app_hoangnm/core/data/remote/api/api_exception.dart';
import 'package:develop_app_hoangnm/core/data/repositories/account_repository.dart';
import 'package:develop_app_hoangnm/core/data/share_preference/spref_user_model.dart';
import 'package:develop_app_hoangnm/core/l10n/strings.dart';
import 'package:develop_app_hoangnm/core/navigator/top_screen/top_screen_navigator_routes.dart';
import 'package:develop_app_hoangnm/core/utils/log_utils.dart';
import 'package:develop_app_hoangnm/view_models/base_view_model.dart';

import 'package:flutter/cupertino.dart';

class ChangePasswordViewModel extends BaseViewModel {
  final AccountRepository _accountRepository = AccountRepository();

  final TextEditingController oldPasswordTextFieldController =
      TextEditingController();
  final TextEditingController newPasswordTextFieldController =
      TextEditingController();
  final TextEditingController confirmPasswordTextFieldController =
      TextEditingController();

  @override
  void onInitViewModel(BuildContext context) {
    super.onInitViewModel(context);
    LogUtils.d("[$runtimeType][INIT] => ChangePasswordViewModel");
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.of(context)!.confirmPasswordRequired;
    }
    if (newPasswordTextFieldController.text != value) {
      return Strings.of(context)!.comparePasswordError;
    }
    return null;
  }

  Future<void> onPressChangePassword() async {
    try {
      final res = await _accountRepository.updatePassword(
          oldPasswordTextFieldController.text,
          newPasswordTextFieldController.text,
          confirmPasswordTextFieldController.text);
      if (res != null && res.status != null && res.status!) {
        // Remove information of current user
        SPrefUserModel().removeDataUser(SPrefUserModel.accessTokenKey);
        SPrefUserModel().removeDataUser(SPrefUserModel.refreshTokenKey);
        SPrefUserModel().removeDataUser(SPrefUserModel.expirationKey);
        SPrefUserModel().removeDataUser(SPrefUserModel.expiresKey);
        SPrefUserModel().removeDataUser(SPrefUserModel.rememberMeKey);
        SPrefUserModel().removeDataUser(SPrefUserModel.emailKey);
        SPrefUserModel().removeDataUser(SPrefUserModel.passwordKey);
        removeNotifier();
        _onOpenSignInScreen();
      } else {
      }
    } on ApiException catch (e) {
      LogUtils.d("[$runtimeType][API_ERROR] => $e");
    } on Exception catch (e) {
      LogUtils.d("[$runtimeType][HANDLER_ERROR] => $e");
    }
  }

  String? validateOldPassword(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.of(context)!.passwordOldRequired;
    }
    return null;
  }

  void _onOpenSignInScreen() {
    TopScreenNavigatorRoutes().openSignInView(context);
  }
}
