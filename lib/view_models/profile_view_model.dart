import 'package:develop_app_hoangnm/core/data/models/profile_model.dart';
import 'package:develop_app_hoangnm/core/data/repositories/account_repository.dart';
import 'package:develop_app_hoangnm/view_models/base_view_model.dart';

import 'package:flutter/material.dart';

class ProfileViewModel extends BaseViewModel {
  ProfileModel? profileModel;

  DataProfileModel? get data => profileModel?.data;

  final AccountRepository _accountRepository = AccountRepository();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  @override
  Future<void> onInitViewModel(BuildContext context) async {
    await getProfile();
  }

  Future<void> getProfile({bool isFirstLoad = true}) async {
    try {
      if (isFirstLoad) {
        _isLoading = true;
      }
      final res = await _accountRepository.getProfile();
      profileModel = res;
      _isLoading = false;
      updateUI();
    } on Exception {
      _isLoading = false;
    }
    notifyListeners();
  }
}
