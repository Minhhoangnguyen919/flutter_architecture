class ApiEndPointConstants {
  const ApiEndPointConstants._();

  static const String signup = "/authenticate/register";
  static const String signIn = "/authenticate/login";
  static const String resetPassword = "/authenticate/forgot-password";
  static const String updatePassword = "/user/update-password";
  static const String getProfile = "/user/get-me";
  static const String updateProfile = "/user/update-profile";
  static const String refreshToken = "/authenticate/refresh-token";
}
