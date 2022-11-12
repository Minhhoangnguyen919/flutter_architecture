import 'package:develop_app_hoangnm/core/utils/log_utils.dart';
import 'package:flutter/material.dart';

class BaseDimens {
  BuildContext? usedContext;

  /// Keep Current Device's Orientation
  /// Set value when device change orientation
  Orientation _orientation = Orientation.portrait;

  Orientation get orientation => _orientation;

  double fullWidth = 0;

  double fullHeight = 0;

  double textScaleFactor = 0;

  // ステータスバーとホームインジケータの値が正常に取れないViewがあるため、staticで値を保持する
  static double staticStatusBarHeight = 0;
  static double staticHomeIndicatorHeight = 0;

  double statusBarHeight = 0;

  double homeIndicatorHeight = 0;

  double bottomToolBarHeight = 0;

  double fullWidthSafeArea = 0;

  double fullHeightSafeArea = 0;

  double headerTabHeight = 0;

  double headerTabHeightWidthStatusBar = 0;

  double headerBorderHeight = 0;

  double footerTabHeight = 0;

  static double _fullWidthChange = 0.0;
  double get fullWidthChange => _fullWidthChange;

  static double _fullHeightChange = 0.0;
  double get fullHeightChange => _fullHeightChange;

  //Width & Height with SafeArea
  void calculatorRatio<T>(BuildContext context) {
    /// Set new orientation
    _orientation = MediaQuery.of(context).orientation;

    fullWidth = MediaQuery.of(context).size.width;
    fullHeight = MediaQuery.of(context).size.height;
    // Detect font scale
    textScaleFactor = MediaQuery.of(context).textScaleFactor;

    /// [BEGIN] ステータスバーとホームインジケータの値が正常に取れないViewがあるため、staticで値を保持します。
    /// 　　　　 staticに保持された値をstatusBarHeightまたはhomeIndicatorHeightに代入して使用します。
    // 各Viewで新規に値を取得する
    final newStatusBarHeight = MediaQuery.of(context).padding.top;
    final newHomeIndicatorHeight = MediaQuery.of(context).padding.bottom;
    // 値を更新する時の条件：①新規に取れた値が0でない時 & ②古い値と新規の値で異なっていた時
    if ((newStatusBarHeight != 0) &&
        (newStatusBarHeight != staticStatusBarHeight)) {
      staticStatusBarHeight = newStatusBarHeight;
    }
    // 使用する変数にstaticの値を代入する
    statusBarHeight = staticStatusBarHeight;
    // 値を更新する時の条件：①新規に取れた値が0でない時 & ②古い値と新規の値で異なっていた時
    if ((newHomeIndicatorHeight != 0) &&
        (newHomeIndicatorHeight != staticHomeIndicatorHeight)) {
      staticHomeIndicatorHeight = newHomeIndicatorHeight;
    }
    // 使用する変数にstaticの値を代入する
    // BaseDimensを継承するDimensクラスからのstatic参照を防ぐため、非static変数に再代入する
    // 実際の計算には非static変数を使用する
    homeIndicatorHeight = staticHomeIndicatorHeight;

    /// [END]

    fullWidthSafeArea = fullWidth;
    fullHeightSafeArea = fullHeight - (statusBarHeight + homeIndicatorHeight);

    // 0.08 is 8%
    headerTabHeight = fullHeightSafeArea * 0.08;

    // ステータスバーを含む自作のヘッダーの高さ（※SafeAreaで使用しない）
    headerTabHeightWidthStatusBar = headerTabHeight + statusBarHeight;

    headerBorderHeight = fullHeightSafeArea * 0.001;

    // 0.08 is 8%
    footerTabHeight = (fullHeightSafeArea * 0.08) + homeIndicatorHeight;

    _fullHeightChange = (orientation == Orientation.portrait)
        ? fullHeightSafeArea
        : fullWidthSafeArea - statusBarHeight - homeIndicatorHeight;

    _fullWidthChange = (orientation == Orientation.portrait)
        ? fullWidthSafeArea
        : fullHeightSafeArea + statusBarHeight + homeIndicatorHeight;

    LogUtils.d("Width: $fullWidthSafeArea - Height: $fullHeightSafeArea");
    LogUtils.d("calculatorRatio<$T>");
    LogUtils.d('footerTabHeight:$footerTabHeight, headerTabHeight:$headerTabHeight');

    initialDimens<T>();
  }

  //Size determination for each screen
  void initialDimens<T>() {}

  void allowCalculatorSize(
      {required BuildContext context, required Function calculatorSizeFunc}) {
    if (fullWidth == 0 || fullHeight == 0 || usedContext == null) {
      LogUtils.methodOut(message: "calculatorSize");
      usedContext = context;
      calculatorSizeFunc.call();
    }
    final mediaQueryData = MediaQuery.of(context);
    final newWidth = mediaQueryData.size.width;
    final newHeight = mediaQueryData.size.height;
    final newTextScaleFactor = mediaQueryData.textScaleFactor;
    final newOrientation = mediaQueryData.orientation;
    final result = newWidth != fullWidth ||
        newHeight != fullHeight ||
        newTextScaleFactor != textScaleFactor ||
        newOrientation != _orientation;
    if (result) {
      LogUtils.methodOut(message: "calculatorSize");
      calculatorSizeFunc.call();
    }
  }

  // Function refactor allowCalculatorSize.
  bool checkAllowReCalculatorSize(BuildContext context) {
    if (fullWidth == 0 || fullHeight == 0 || usedContext == null) {
      LogUtils.methodOut(message: "allow re-calculator size");
      usedContext = context;
      return true;
    }
    final mediaQueryData = MediaQuery.of(context);
    final newWidth = mediaQueryData.size.width;
    final newHeight = mediaQueryData.size.height;
    final newTextScaleFactor = mediaQueryData.textScaleFactor;
    final newOrientation = mediaQueryData.orientation;
    final result = newWidth != fullWidth ||
        newHeight != fullHeight ||
        newTextScaleFactor != textScaleFactor ||
        newOrientation != _orientation;
    if (result) {
      LogUtils.methodOut(message: "allow re-calculator size");
      return true;
    }
    return false;
  }
}
