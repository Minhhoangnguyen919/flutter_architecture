import 'package:develop_app_hoangnm/core/constants/api_end_point.dart';
import 'package:develop_app_hoangnm/core/data/models/user_model.dart';
import 'package:develop_app_hoangnm/core/data/remote/services/base_service.dart';

class AuthService extends BaseService {
  Future<UserModel?> signIn(String email, String password) async {
    final body = '{"email": "$email", "password": "$password"}';
    return await post(
      ApiEndPointConstants.signIn,
      body: body,
      mapper: (json) => UserModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<DataResponseModel?> signUp(
      String email, String password, String confirmPassword) async {
    final body =
        '{"email": "$email", "password": "$password", "passwordConfirmation": "$confirmPassword"}';
    return await post(
      ApiEndPointConstants.signup,
      body: body,
      mapper: (json) =>
          DataResponseModel.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<DataResponseModel?> onGetNewPassword(String email) async {
    final body = '{"email": "$email"}';
    return await post(
      ApiEndPointConstants.resetPassword,
      body: body,
      mapper: (json) =>
          DataResponseModel.fromJson(json as Map<String, dynamic>),
    );
  }
}
