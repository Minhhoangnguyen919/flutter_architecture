import 'package:develop_app_hoangnm/ui/shared/colors.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_manager.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_shopping_bag_view.dart';
import 'package:develop_app_hoangnm/ui/views/base_view.dart';
import 'package:develop_app_hoangnm/view_models/shoping_bag_view_model.dart';
import 'package:flutter/material.dart';


class ShoppingBagView extends BaseView {
  const ShoppingBagView({Key? key}) : super(key: key);

  @override
  ShoppingBagViewState createState() => ShoppingBagViewState();
}

class ShoppingBagViewState extends BaseViewState<ShoppingBagView,
    ShoppingBagViewModel, DimensShoppingBagView> {

  @override
  void createDimens() {
    super.createDimens();
    viewSize = DimensManager().dimensShoppingBagView;
  }

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = ShoppingBagViewModel()..onInitViewModel(context);
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColors.backgroundColor,
      body: Container(
        alignment: Alignment.center,
        child: Image.asset(
          "assets/images/splashLogo.png",
        ),
      ),
    );
  }

}
