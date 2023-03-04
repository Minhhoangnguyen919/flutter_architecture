import 'package:develop_app_hoangnm/ui/shared/colors.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_search.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_manager.dart';
import 'package:develop_app_hoangnm/conponent/base_view/base_view.dart';
import 'package:develop_app_hoangnm/conponent/bottom_bar_view/search_view/search_view_model.dart';
import 'package:flutter/material.dart';


class SearchView extends BaseView {
  const SearchView({Key? key}) : super(key: key);

  @override
  SearchViewState createState() => SearchViewState();
}

class SearchViewState extends BaseViewState<SearchView,
    SearchViewModel, DimensSearchView> {

  @override
  void createDimens() {
    super.createDimens();
    viewSize = DimensManager().dimensSearchView;
  }

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = SearchViewModel()..onInitViewModel(context);
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
