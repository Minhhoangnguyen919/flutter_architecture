import 'package:develop_app_hoangnm/core/data/repositories/auth_repository.dart';
import 'package:develop_app_hoangnm/core/data/share_preference/spref_user_model.dart';
import 'package:develop_app_hoangnm/core/l10n/strings.dart';
import 'package:develop_app_hoangnm/core/navigator/top_screen/top_screen_navigator_routes.dart';
import 'package:develop_app_hoangnm/core/utils/log_utils.dart';
import 'package:develop_app_hoangnm/view_models/base_view_model.dart';

import 'package:flutter/cupertino.dart';

class SignInViewModel extends BaseViewModel {
  final AuthRepository _authRepository = AuthRepository();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isCheckRememberMe = false;

  bool get isCheckRememberMe => _isCheckRememberMe;

  @override
  Future<void> onInitViewModel(BuildContext context) async {
    super.onInitViewModel(context);
    await SPrefUserModel().onInit();
    inItData();
    LogUtils.d("[$runtimeType][LOGIN_VIEW_MODEL] => INIT");
  }

  void checkedRememberMe(bool? isChecked) {
    _isCheckRememberMe = isChecked!;
    updateUI();
  }

  Future<void> onSignIn() async {
    try {
      final res = await _authRepository.signIn(
          emailController.text, passwordController.text);
      SPrefUserModel().setRemember(_isCheckRememberMe);
      if (res != null) {
        SPrefUserModel().setAccessToken(res.accessToken);
        SPrefUserModel().setRefreshToken(res.refreshToken);
        SPrefUserModel().setExpiration(res.expiration);
        SPrefUserModel().setExpires(res.expires);
        SPrefUserModel().setEmail(emailController.text);
        SPrefUserModel().setPassword(passwordController.text);
        removeNotifier();
        _transitionToLadingView();
      }
    } on Exception {
      showToastError(
        Strings.of(context)!.anErrorHasOccurred,
      );
    }
  }

  void inItData() {
    final bool? remember = SPrefUserModel().getRemember();
    final String? expiration = SPrefUserModel().getExpiration();
    if (expiration == null) {
      return;
    }
    DateTime expirationDateTime = DateTime.parse(expiration);
    if (expirationDateTime.isAfter(DateTime.now()) &&
        remember != null &&
        remember) {
      final String? email = SPrefUserModel().getEmail();
      final String? password = SPrefUserModel().getPassword();
      _isCheckRememberMe = remember;
      emailController.text = email ?? "";
      passwordController.text = password ?? "";
      notifyListeners();
    }
  }

  void _transitionToLadingView() {
    TopScreenNavigatorRoutes().openLandingView(context);
  }

  String? validatePassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return Strings.of(context)!.passwordRequired;
    }
    return null;
  }
}
