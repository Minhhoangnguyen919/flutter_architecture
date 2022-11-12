import 'package:develop_app_hoangnm/core/utils/log_utils.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/base_dimens.dart';
import 'package:develop_app_hoangnm/view_models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseView extends StatefulWidget {
  const BaseView({Key? key}) : super(key: key);

  @override
  BaseViewState createState() => BaseViewState();
}

class BaseViewState<V extends BaseView, VM extends BaseViewModel,
    D extends BaseDimens> extends State<V> with WidgetsBindingObserver {
  late final VM viewModel;
  late final D viewSize;
  bool _isChangeMetrics = false;

  @override
  void initState() {
    super.initState();
    createDimens();
    createViewModel();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => onBuildCompleted());
  }

  void createDimens() {
    // Override for create Dimens
  }

  void createViewModel() {
    // Override for create ViewModel each View
  }

  bool isNeedReBuildByOtherViewModel() {
    return true;
  }

  /// Register notify when viewModel other call notifyListener()
  void onBuildCompleted() {
    viewModel.onBuildComplete(
      isNeedReBuildByOtherViewModel: isNeedReBuildByOtherViewModel(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !Navigator.canPop(context);
      },
      child: ChangeNotifierProvider<VM>(
        create: (_) => viewModel,
        child: Selector<VM, bool>(
          // When size change selector here will check and re-calculator size
          selector: (_, viewModel) => viewModel.checkReCalculatorSize(
              allowReCalculatorSize:
                  viewSize.checkAllowReCalculatorSize(context)),
          shouldRebuild: (prev, next) => next == true,
          builder: (_, calculatorSize, __) {
            if (calculatorSize) {
              // If size device change will re-calculator size
              viewSize.calculatorRatio<V>(context);
              calculatorSizeForOtherWidget();
            }
            return buildView(context);
          },
        ),
      ),
    );
  }

  /// Override for each view ...
  Widget buildView(BuildContext context) {
    return Container();
  }

  void calculatorSizeForOtherWidget() {
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    LogUtils.d("[$runtimeType] ChangeMetrics");
    _isChangeMetrics = true;
    viewModel.updateUI();
  }

  @override
  void didChangeTextScaleFactor() {
    super.didChangeTextScaleFactor();
    LogUtils.d("[$runtimeType] ChangeTextScale");
    if (!_isChangeMetrics) {
      viewModel.updateUI();
    }
    _isChangeMetrics = false;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
