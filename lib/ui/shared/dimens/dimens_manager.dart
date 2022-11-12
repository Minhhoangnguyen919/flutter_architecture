import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_change_password_view.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_course_detail_view.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_forgot_password_view.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_list_courses_view.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_signup_view.dart';
import 'package:develop_app_hoangnm/ui/views/main_view.dart';
import 'package:develop_app_hoangnm/ui/views/sign_up_view.dart';
import 'package:develop_app_hoangnm/ui/views/profile_view.dart';
import 'package:develop_app_hoangnm/ui/views/update_profile_view.dart';
import 'package:develop_app_hoangnm/ui/views/sign_in_view.dart';
import 'package:flutter/cupertino.dart';
import 'dimens_landing_view.dart';
import 'dimens_signin_view.dart';
import 'dimens_main_view.dart';
import 'dimens_profile_view.dart';
import 'dimens_update_profile_view.dart';

/// Manage size view
class DimensManager {
  ///
  late DimensMainView _dimensMainView;

  DimensMainView get mainViewSize => _dimensMainView;

  late DimensForgotPasswordView _dimensForgotPasswordView;

  DimensForgotPasswordView get forgotPasswordViewSize =>
      _dimensForgotPasswordView;

  late DimensChangePasswordView _dimensChangePasswordView;

  DimensChangePasswordView get changePasswordViewSize =>
      _dimensChangePasswordView;

  /// Dimens landing view
  late DimensLandingView _dimensLandingView;

  DimensLandingView get landingViewSize => _dimensLandingView;

  /// Dimens login(sign in) view
  late DimensSignInView _dimensSignInView;

  DimensSignInView get signInViewSize => _dimensSignInView;

  late DimensSignUpView _dimensSignUpView;

  DimensSignUpView get signUpViewSize => _dimensSignUpView;

  late DimensProfileView _dimensProfileView;

  DimensProfileView get profileViewSize => _dimensProfileView;

  late DimensUpdateProfileView _dimensEditProfileView;

  DimensUpdateProfileView get editProfileViewSize => _dimensEditProfileView;

  late DimensListCoursesView _dimensListCoursesView;

  DimensListCoursesView get listCoursesViewSize => _dimensListCoursesView;

  late DimensCourseDetailView _dimensCourseDetailView;

  DimensCourseDetailView get courseDetailViewSize => _dimensCourseDetailView;

  static DimensManager? _instance;

  factory DimensManager() {
    return _instance ??= DimensManager._();
  }

  /// Constructor
  DimensManager._() {
    _calculatorLanguage();
    _initializeDimens();
  }

  void destroyInstance() {
    //インスタンス破棄
    _instance = null;
  }

  //TODO:
  void _calculatorLanguage() {
    //TODO: Locale myLocale = Localizations.localeOf(context);
  }

  void _initializeDimens() {
    /// [BEGIN] Screen Size
    // MainView
    _dimensMainView = DimensMainView();
    //ProfileView
    _dimensProfileView = DimensProfileView();
    //EditProfileView
    _dimensEditProfileView = DimensUpdateProfileView();

    // forgot password
    _dimensForgotPasswordView = DimensForgotPasswordView();
    // Change password
    _dimensChangePasswordView = DimensChangePasswordView();
    // LoginView(Sign In)
    _dimensSignInView = DimensSignInView();
    // LandingView
    _dimensLandingView = DimensLandingView();
    // SignUpView
    _dimensSignUpView = DimensSignUpView();
    // ListCoursesView
    _dimensListCoursesView = DimensListCoursesView();

    _dimensCourseDetailView = DimensCourseDetailView();

    /// [END] Widget Size
    /// TODO: Add more
  }

  void calculatorRatio<T>(BuildContext context) {
    switch (T) {
      case MainView:
        _dimensMainView.calculatorRatio<T>(context);
        break;
      case SignInView:
        _dimensMainView.calculatorRatio<T>(context);
        break;
      case SignUpView:
        _dimensSignUpView.calculatorRatio<T>(context);
        break;
      case ProfileView:
        _dimensProfileView.calculatorRatio<T>(context);
        break;
      case UpdateProfileView:
        _dimensEditProfileView.calculatorRatio<T>(context);
        break;
      default:
        // TODO: Handle later
        break;

      ///Add
    }
  }
}
