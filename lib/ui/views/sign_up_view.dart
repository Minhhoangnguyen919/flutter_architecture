import 'package:develop_app_hoangnm/core/constants/constants.dart';
import 'package:develop_app_hoangnm/core/l10n/strings.dart';
import 'package:develop_app_hoangnm/core/utils/check_validate_utils.dart';
import 'package:develop_app_hoangnm/ui/shared/app_button.dart';
import 'package:develop_app_hoangnm/ui/shared/app_input.dart';
import 'package:develop_app_hoangnm/ui/shared/app_theme.dart';
import 'package:develop_app_hoangnm/ui/shared/colors.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_manager.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_signup_view.dart';
import 'package:develop_app_hoangnm/ui/views/base_view.dart';
import 'package:develop_app_hoangnm/view_models/sign_up_view_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpView extends BaseView {
  const SignUpView({Key? key}) : super(key: key);

  @override
  SignUpViewState createState() => SignUpViewState();
}

class SignUpViewState
    extends BaseViewState<SignUpView, SignUpViewModel, DimensSignUpView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void createDimens() {
    super.createDimens();
    viewSize = DimensManager().signUpViewSize;
  }

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = SignUpViewModel()..onInitViewModel(context);
  }

  @override
  void onBuildCompleted() {
    super.onBuildCompleted();
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
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: viewSize.contentPaddingHorizontal,
        ),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildTitle(),
              SizedBox(height: viewSize.spaceVertical),
              _buildEmailTextField(),
              SizedBox(height: viewSize.spaceVertical),
              _buildPasswordTextField(),
              SizedBox(height: viewSize.spaceVertical),
              _buildConfirmPasswordTextField(),
              SizedBox(height: viewSize.spaceVertical),
              _buildRememberMeCheckbox(),
              SizedBox(height: viewSize.spaceVertical),
              _buildSignUpBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          Strings.of(context)!.registerAccountTitle,
          style: AppText.text33,
        ),
        SizedBox(
          height: viewSize.spaceVertical,
        ),
        Text(
          Strings.of(context)!.registerAccountContent,
          style: AppText.text21.copyWith(color: HexColors.grey),
        ),
        SizedBox(
          height: viewSize.spaceVertical,
        ),
      ],
    );
  }

  Widget _buildEmailTextField() {
    return AppInput(
      controller: viewModel.emailTextFieldController,
      keyboardType: TextInputType.text,
      validator: (value) => CheckValidateUtils.validateEmail(value, context),
      hintText: Strings.of(context)!.emailAddress,
      prefixIcon: const Icon(Icons.email),
    );
  }

  Widget _buildPasswordTextField() {
    return AppInput(
      controller: viewModel.passwordTextFieldController,
      keyboardType: TextInputType.text,
      obscureText: true,
      validator: (value) => CheckValidateUtils.validatePassword(value, context),
      hintText: Strings.of(context)!.password,
      prefixIcon: const Icon(Icons.key),
    );
  }

  Widget _buildConfirmPasswordTextField() {
    return AppInput(
      controller: viewModel.confirmPasswordTextFieldController,
      keyboardType: TextInputType.text,
      obscureText: true,
      validator: (value) => viewModel.validateConfirmPassword(value),
      hintText: Strings.of(context)!.repeatPassword,
      prefixIcon: const Icon(Icons.key),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Row(
      children: <Widget>[
        Selector<SignUpViewModel, bool>(
            selector: (_, viewModel) =>
                viewModel.isCheckAgreeTermsAndConditions,
            builder: (_, isCheckRemember, __) {
              return Checkbox(
                value: isCheckRemember,
                side: MaterialStateBorderSide.resolveWith(
                  (states) => BorderSide(width: 1.0, color: HexColors.grey),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(Constants.radiusCircularCheckbox),
                ),
                checkColor: HexColors.white,
                activeColor: HexColors.activeColor,
                onChanged: (value) {
                  viewModel.checkedAgreeTermsAndConditions(value);
                },
              );
            }),
        Expanded(
          child: Text(
            Strings.of(context)!.agreeTermsAndConditions,
            textAlign: TextAlign.left,
            style: AppText.text18.copyWith(color: HexColors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpBtn() {
    return AppButton(
      backgroundColor: HexColors.colorButtonLogin,
      label: Strings.of(context)!.btnSignUp,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          viewModel.onPressSignUp();
        }
      },
    );
  }
}
