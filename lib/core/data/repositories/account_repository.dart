import 'package:develop_app_hoangnm/core/data/models/profile_model.dart';
import 'package:develop_app_hoangnm/core/data/models/user_model.dart';
import 'package:develop_app_hoangnm/core/data/remote/services/account_service.dart';

class AccountRepository {
  final AccountService _accountService = AccountService();

  Future<ProfileModel?> getProfile() async {
    try {
      final res = await _accountService.getProfile();
      return res;
    } on Exception {
      rethrow;
    }
  }

  Future<DataResponseModel?> updateProfile(DataToUpdate data) async {
    try {
      final res = await _accountService.updateProfile(data);
      return res;
    } on Exception {
      rethrow;
    }
  }

  Future<DataResponseModel?> updatePassword(
      String currentPassword, String newPassword, String newPasswordConfirmation) async {
    try {
      final res = await _accountService.updatePassword(
          currentPassword, newPassword, newPasswordConfirmation);
      return res;
    } on Exception {
      rethrow;
    }
  }
}
