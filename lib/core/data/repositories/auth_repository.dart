import 'package:develop_app_hoangnm/core/data/models/user_model.dart';
import 'package:develop_app_hoangnm/core/data/remote/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  Future<UserModel?> signIn(String email, String password) async {
    try {
      final res = await _authService.signIn(email, password);
      return res;
    } on Exception {
      rethrow;
    }
  }

  Future<DataResponseModel?> signUp(
      String email, String password, String confirmPassword) async {
    try {
      final res = await _authService.signUp(email, password, confirmPassword);
      return res;
    } on Exception {
      rethrow;
    }
  }

  Future<DataResponseModel?> onGetNewPassword(String email) async {
    try {
      final res = await _authService.onGetNewPassword(email);
      return res;
    } on Exception {
      rethrow;
    }
  }
}
