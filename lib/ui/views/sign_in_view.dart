import 'package:develop_app_hoangnm/core/utils/check_validate_utils.dart';
import 'package:develop_app_hoangnm/ui/shared/app_button.dart';
import 'package:develop_app_hoangnm/ui/shared/app_input.dart';
import 'package:develop_app_hoangnm/ui/shared/app_theme.dart';
import 'package:develop_app_hoangnm/ui/views/base_view.dart';
import 'package:develop_app_hoangnm/core/l10n/strings.dart';
import 'package:develop_app_hoangnm/view_models/sign_in_view_model.dart';
import 'package:develop_app_hoangnm/ui/shared/colors.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_signin_view.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_manager.dart';
import 'package:develop_app_hoangnm/core/navigator/top_screen/top_screen_navigator_routes.dart';
import 'package:develop_app_hoangnm/core/utils/log_utils.dart';

import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignInView extends BaseView {
  const SignInView({Key? key}) : super(key: key);

  @override
  SignInViewState createState() => SignInViewState();
}

class SignInViewState
    extends BaseViewState<SignInView, SignInViewModel, DimensSignInView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void createDimens() {
    super.createDimens();
    viewSize = DimensManager().signInViewSize;
  }

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = SignInViewModel()..onInitViewModel(context);
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: HexColors.white,
      body: GestureDetector(
        onTap: () =>
            FocusScope.of(_scaffoldKey.currentContext ?? context).unfocus(),
        child: Container(
          height: viewSize.contentHeight,
          alignment: Alignment.center,
          child: _buildSignIn(),
        ),
      ),
    );
  }

  Widget _buildSignIn() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(viewSize.contentPaddingHorizontal),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildTitle(),
            SizedBox(height: viewSize.spaceVertical),
            _buildMessageWelcome(),
            SizedBox(height: viewSize.spaceVerticalPaddingContent),
            AppInput(
              prefixIcon: const Icon(Icons.email),
              hintText: Strings.of(context)!.emailAddressHint,
              controller: viewModel.emailController,
              validator: (value) =>
                  CheckValidateUtils.validateEmail(value, context),
            ),
            SizedBox(height: viewSize.spaceVertical),
            AppInput(
              prefixIcon: const Icon(Icons.key),
              hintText: Strings.of(context)!.passwordHint,
              controller: viewModel.passwordController,
              obscureText: true,
              validator: (value) => viewModel.validatePassword(value, context),
            ),
            SizedBox(height: viewSize.spaceVertical),
            _checkRememberMe(),
            SizedBox(height: viewSize.spaceVertical),
            AppButton(
                label: Strings.of(context)!.btnSignIn,
                backgroundColor: HexColors.colorButtonLogin,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    viewModel.onSignIn();
                  }
                }),
            SizedBox(height: viewSize.spaceVertical),
            _forgottenPassword(),
            SizedBox(height: viewSize.spaceVerticalPaddingContent),
            _signUpNav(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(Strings.of(context)!.welcomeBack,
        textAlign: TextAlign.center, style: AppText.text33);
  }

  Widget _buildMessageWelcome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          Strings.of(context)!.introduceMessage,
          textAlign: TextAlign.center,
          style: AppText.text21.copyWith(color: HexColors.grey),
        ),
        SizedBox(height: viewSize.spaceVertical),
        Text(
          Strings.of(context)!.introduceLogIn,
          textAlign: TextAlign.center,
          style: AppText.text21.copyWith(color: HexColors.grey),
        ),
      ],
    );
  }

  Widget _checkRememberMe() {
    return Row(
      children: <Widget>[
        Selector<SignInViewModel, bool>(
          selector: (_, viewModel) => viewModel.isCheckRememberMe,
          builder: (_, isCheckRemember, __) {
            return Checkbox(
              value: isCheckRemember,
              side: MaterialStateBorderSide.resolveWith(
                (states) => BorderSide(width: 1.0, color: HexColors.grey),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              checkColor: HexColors.white,
              activeColor: HexColors.activeColor,
              onChanged: (value) => viewModel.checkedRememberMe(value),
            );
          },
        ),
        Expanded(
          child: Text(
            Strings.of(context)!.rememberAccount,
            textAlign: TextAlign.left,
            style: AppText.text18.copyWith(color: HexColors.grey),
          ),
        ),
      ],
    );
  }

  Widget _forgottenPassword() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        child: Text(
          Strings.of(context)!.forgottenPassword,
          style: AppText.text21.copyWith(color: Colors.blue),
        ),
        onPressed: () {
          LogUtils.d("[$runtimeType][OPEN_FORGOT_PASSWORD_SCREEN] => RUNNING");
          TopScreenNavigatorRoutes().openForgotPasswordView(context);
        },
      ),
    );
  }

  Widget _signUpNav() {
    return Container(
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: Strings.of(context)!.signUpNavigation,
              style: AppText.text21.copyWith(color: HexColors.grey),
            ),
            TextSpan(
              text: Strings.of(context)!.btnSignUp,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  LogUtils.d("[$runtimeType][OPEN_SIGN_UP_SCREEN] => RUNNING");
                  TopScreenNavigatorRoutes().openSignUpView(context);
                },
              style: AppText.text21.copyWith(color: Colors.blue),
            )
          ],
        ),
      ),
    );
  }
}
