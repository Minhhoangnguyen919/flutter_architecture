import 'package:develop_app_hoangnm/core/utils/log_utils.dart';
import 'package:develop_app_hoangnm/core/utils/network_utils.dart';
import 'package:develop_app_hoangnm/core/utils/toast_util.dart';
import 'package:flutter/material.dart';

/// BaseViewModel
abstract class BaseViewModel extends ChangeNotifier {
  // static privateなChangeNotifierリストのメンバを持つ。
  static final List<ChangeNotifier> _notifierList = [];

  List<ChangeNotifier> get notifierList =>
      _notifierList; // 破棄されるかどうか_listenersオブジェクトをチェック

  bool _isEmptyListeners = false;

  bool _isShowLoading = false;

  bool get isShowLoading => _isShowLoading;

  late BuildContext context;

  BaseViewModel({bool isShowLoading = false}) {
    _isShowLoading = isShowLoading;
  }

  void setLoading({required bool isShow}) {
    _isShowLoading = isShow;
    updateCurrentUI();
  }

  bool hasNetworkConnection() {
    return NetworkUtils.hasConnection();
  }

  void onInitViewModel(BuildContext context) {
    LogUtils.i("$runtimeType");
    this.context = context;
  }

  // Function will check size device change
  bool checkReCalculatorSize({required bool allowReCalculatorSize}) {
    return allowReCalculatorSize;
  }

  // When View build success, allow call setState().
  // When need update UI by other viewModels set isNeedReBuildByOtherViewModel is true
  void onBuildComplete({bool isNeedReBuildByOtherViewModel = true}) {
    if (isNeedReBuildByOtherViewModel && !_notifierList.contains(this)) {
      LogUtils.d("add [$this] notifier list");
      // 自身のインスタンス(this)を_notifierListに追加する。
      _notifierList.add(this);
    }
  }

  void updateCurrentUI() {
    LogUtils.d("[updateCurrentUI:$runtimeType]");
    notifyListeners();
  }

  void updateUI() {
    LogUtils.d("[updateUI:$runtimeType]");
    // 破棄される_listenersオブジェクトの場合、状態の変化を通知しない
    if (!_isEmptyListeners) {
      // 状態の変化を通知
      notifyListeners();
    }
    if (_notifierList.isEmpty) return;
    // _notifierList分のnotifyListeners()を呼び出す。
    for (ChangeNotifier notifier in _notifierList) {
      if (notifier != this) {
        notifier.notifyListeners();
      }
    }
  }

  void showToastSuccess(String? message) {
    MessageUtils.showToastMessage(context, message ?? "",
        backgroundColor: Colors.green);
  }

  void showToastError(String? message) {
    MessageUtils.showToastMessage(context, message ?? "");
  }

  // Call when:
  // + dispose
  // + change screen
  void removeNotifier() {
    if (_notifierList.contains(this)) {
      LogUtils.i("viewModel:remove:notifier[$runtimeType]");
      // 自身のインスタンス(this)を_notifierListから削除する。
      _notifierList.remove(this);
    }
  }

  // Call when:
  // + dispose
  // + change screen
  void clearNotifier() {
    _notifierList.clear();
  }

  /// 破棄の処理
  @override
  void dispose() {
    LogUtils.i("viewModel:dispose[$runtimeType]");
    _isEmptyListeners = true;
    removeNotifier();
    super.dispose();
  }
}
