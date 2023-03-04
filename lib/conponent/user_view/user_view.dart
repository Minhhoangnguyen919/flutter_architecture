import 'package:develop_app_hoangnm/conponent/user_view/user_view_model.dart';
import 'package:develop_app_hoangnm/ui/shared/colors.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_manager.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_user_view.dart';
import 'package:develop_app_hoangnm/conponent/base_view/base_view.dart';
import 'package:flutter/material.dart';


class UserView extends BaseView {
  const UserView({Key? key}) : super(key: key);

  @override
  UserViewState createState() => UserViewState();
}

class UserViewState extends BaseViewState<UserView,
    UserViewModel, DimensUserView> {

  @override
  void createDimens() {
    super.createDimens();
    viewSize = DimensManager().dimensUserView;
  }

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = UserViewModel()..onInitViewModel(context);
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColors.backgroundColorSplash,
      body: Container(
        alignment: Alignment.center,
        child: Image.asset(
          "assets/images/splashLogo.png",
        ),
      ),
    );
  }

}
