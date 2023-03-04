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

    final newStatusBarHeight = MediaQuery.of(context).padding.top;
    final newHomeIndicatorHeight = MediaQuery.of(context).padding.bottom;
    if ((newStatusBarHeight != 0) &&
        (newStatusBarHeight != staticStatusBarHeight)) {
      staticStatusBarHeight = newStatusBarHeight;
    }
    statusBarHeight = staticStatusBarHeight;
    if ((newHomeIndicatorHeight != 0) &&
        (newHomeIndicatorHeight != staticHomeIndicatorHeight)) {
      staticHomeIndicatorHeight = newHomeIndicatorHeight;
    }
    homeIndicatorHeight = staticHomeIndicatorHeight;

    /// [END]

    fullWidthSafeArea = fullWidth;
    fullHeightSafeArea = fullHeight - (statusBarHeight + homeIndicatorHeight);

    // 0.08 is 8%
    headerTabHeight = fullHeightSafeArea * 0.08;

    // ステータスバーを含む自作のヘッダーの高さ（※SafeAreaで使用しない）
    headerTabHeightWidthStatusBar = headerTabHeight + statusBarHeight;

    headerBorderHeight = fullHeightSafeArea * 0.001;

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
