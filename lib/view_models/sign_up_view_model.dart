import 'package:develop_app_hoangnm/core/data/remote/api/api_exception.dart';
import 'package:develop_app_hoangnm/core/data/repositories/auth_repository.dart';
import 'package:develop_app_hoangnm/core/l10n/strings.dart';
import 'package:develop_app_hoangnm/core/utils/log_utils.dart';
import 'package:develop_app_hoangnm/view_models/base_view_model.dart';

import 'package:flutter/material.dart';

class SignUpViewModel extends BaseViewModel {
  final AuthRepository _authRepository = AuthRepository();

  final TextEditingController emailTextFieldController =
      TextEditingController();
  final TextEditingController passwordTextFieldController =
      TextEditingController();
  final TextEditingController confirmPasswordTextFieldController =
      TextEditingController();

  bool _isCheckAgreeTermsAndConditions = false;

  bool get isCheckAgreeTermsAndConditions => _isCheckAgreeTermsAndConditions;

  void checkedAgreeTermsAndConditions(bool? isChecked) {
    _isCheckAgreeTermsAndConditions = isChecked!;
    updateUI();
  }

  Future<void> onPressSignUp() async {
    LogUtils.d('onPressSignUp');
    setLoading(isShow: true);
    if (!_isCheckAgreeTermsAndConditions) {
      _showToastNotAgreeTermsAndConditions();
      return;
    }
    try {
      final res = await _authRepository.signUp(
          emailTextFieldController.text,
          passwordTextFieldController.text,
          confirmPasswordTextFieldController.text);
      if (res != null && res.status != null && res.status!) {
        showToastSuccess(res.message);
        _backToLoginView();
      } else if (res != null && res.status != null && res.status!) {
        showToastError(res.message!);
      }
    } on ApiException catch (e) {
      showToastError(
          e.failure?.message ?? Strings.of(context)!.anErrorHasOccurred);
    } on Exception {
      showToastError(
        Strings.of(context)!.anErrorHasOccurred,
      );
    }
    setLoading(isShow: false);
  }

  void _showToastNotAgreeTermsAndConditions() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(Strings.of(context)!.checkAgreeTermsAndConditions),
      ),
    );
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.of(context)!.confirmPasswordRequired;
    }
    if (passwordTextFieldController.text != value) {
      return Strings.of(context)!.comparePasswordError;
    }
    return null;
  }

  void _backToLoginView() {
    // When register account success, back to login view
    Navigator.of(context).pop();
  }
}
