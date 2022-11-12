import 'package:develop_app_hoangnm/core/data/remote/api/api_exception.dart';
import 'package:develop_app_hoangnm/core/data/repositories/auth_repository.dart';
import 'package:develop_app_hoangnm/core/data/share_preference/spref_user_model.dart';
import 'package:develop_app_hoangnm/core/l10n/strings.dart';
import 'package:develop_app_hoangnm/core/navigator/top_screen/top_screen_navigator_routes.dart';
import 'package:develop_app_hoangnm/view_models/base_view_model.dart';

import 'package:flutter/material.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  final AuthRepository _authRepository = AuthRepository();

  TextEditingController emailController = TextEditingController();

  Future<void> onGetNewPassword() async {
    try {
      final res = await _authRepository.onGetNewPassword(emailController.text);
      if (res != null && res.status != null && res.status!) {
        showToastSuccess(res.message);
        SPrefUserModel().removeDataUser(SPrefUserModel.accessTokenKey);
        SPrefUserModel().removeDataUser(SPrefUserModel.refreshTokenKey);
        SPrefUserModel().removeDataUser(SPrefUserModel.expirationKey);
        SPrefUserModel().removeDataUser(SPrefUserModel.expiresKey);
        SPrefUserModel().removeDataUser(SPrefUserModel.rememberMeKey);
        SPrefUserModel().removeDataUser(SPrefUserModel.emailKey);
        SPrefUserModel().removeDataUser(SPrefUserModel.passwordKey);
        _onOpenSignInScreen();
      } else if (res != null && res.status != null && !res.status!) {
        showToastError(res.message);
      }
    } on ApiException catch (e) {
      showToastError(
        e.failure?.message ?? Strings.of(context)!.anErrorHasOccurred,
      );
    } on Exception {
      showToastError(
        Strings.of(context)!.anErrorHasOccurred,
      );
    }
    notifyListeners();
  }

  void _onOpenSignInScreen() {
    TopScreenNavigatorRoutes().openSignInView(context);
  }
}
