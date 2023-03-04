import 'package:develop_app_hoangnm/core/enums/enums.dart';
import 'package:develop_app_hoangnm/core/utils/log_utils.dart';
import 'package:develop_app_hoangnm/ui/shared/colors.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_search.dart';
import 'package:develop_app_hoangnm/ui/shared/dimens/dimens_manager.dart';
import 'package:develop_app_hoangnm/conponent/base_view/base_view.dart';
import 'package:develop_app_hoangnm/conponent/bottom_bar_view/search_view/search_view_model.dart';
import 'package:develop_app_hoangnm/ui/shared/fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SearchView extends BaseView {
  const SearchView({Key? key}) : super(key: key);

  @override
  SearchViewState createState() => SearchViewState();
}

class SearchViewState
    extends BaseViewState<SearchView, SearchViewModel, DimensSearchView> {
  final GlobalKey _qrKey = GlobalKey();

  final Map<QRWidgetViewType, Widget?> _cacheQRView = {
    QRWidgetViewType.qrView: null,
    QRWidgetViewType.scanView: null,
  };

  final _kTextQrDescription = TextStyle(
    color: HexColors.white,
    fontFamily: Fonts.notoSansJPMedium,
  );

  @override
  bool isNeedReBuildByOtherViewModel() {
    return false;
  }

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
      backgroundColor: Colors.white54,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Selector<SearchViewModel, QRWidgetViewType>(
            selector: (_, viewModel) => viewModel.qrViewType,
            builder: (_, qrViewType, __) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        _buildQRView(qrViewType, QRWidgetViewType.qrView),
                        _buildQRView(qrViewType, QRWidgetViewType.scanView),
                      ],
                    ),
                  ),
                  _buildQRCodeFooter(qrViewType),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildQRView(QRWidgetViewType currentViewType, QRWidgetViewType viewType) {
    return Offstage(
      offstage: currentViewType != viewType,
      child: _cacheQRView[viewType] ??
          (currentViewType == viewType
              ? _buildCacheQRView(currentViewType)
              : Container()),
    );
  }

  Widget _buildCacheQRView(QRWidgetViewType qrViewType) {
    if (QRWidgetViewType.qrView == qrViewType) {
      return _cacheQRView[QRWidgetViewType.qrView] = _widgetQRCodeView();
    } else {
      return _cacheQRView[QRWidgetViewType.scanView] = _buildQRCodeScan();
    }
  }

  Widget _widgetQRCodeView() {
    return Selector<SearchViewModel, String?>(
      selector: (_, viewModel) => viewModel.urlJsonQrCode,
      builder: (_, qrCodeToken, __) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "SCAN QR CODE",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.greenAccent,
                ),
              ),
            ),
            if (qrCodeToken != null)
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                ),
                padding: const EdgeInsets.all(10),
                child: QrImage(
                  data: qrCodeToken,
                  version: QrVersions.auto,
                  size: viewSize.fullWidthSafeArea * 0.5,
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildQRCodeScan() {
    return SizedBox(
      height: viewSize.fullHeightSafeArea * 0.73,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildQrCodeView(context),
          Positioned(
            top: viewSize.fullHeightSafeArea * 0.03,
            child: _buildResultQR(),
          )
        ],
      ),
    );
  }

  Widget _buildResultQR() {
    return Container(
      width: viewSize.fullWidthSafeArea * 0.7,
      padding: EdgeInsets.all(viewSize.fullWidthSafeArea * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(viewSize.fullWidthSafeArea * 0.012),
      ),
      child: Selector<SearchViewModel, QRScanResult>(
        selector: (_, viewModel) => viewModel.scanDataResult,
        builder: (_, scanDataResult, __) {
          return Text(
            _textByScanResult(scanDataResult),
            style: _kTextQrDescription,
            textAlign: TextAlign.center,
          );
        },
      ),
    );
  }

  Widget _buildQrCodeView(BuildContext context) {
    return QRView(
      key: _qrKey,
      onQRViewCreated: viewModel.onQRViewCreated,
      onPermissionSet: viewModel.onQRViewPermissionSet,
      overlay: QrScannerOverlayShape(
        borderColor: HexColors.grey,
        borderRadius: 0,
        borderLength: 30,
        borderWidth: 5,
      ),
    );
  }

  Widget _buildQRCodeFooter(QRWidgetViewType qrViewType) {
    return Container(
      padding: EdgeInsets.only(
        top: viewSize.fullHeightSafeArea * 0.007,
        bottom: viewSize.fullHeightSafeArea * 0.007,
      ),
      height: viewSize.fullHeightSafeArea * 0.126,
      width: double.infinity,
      color: Colors.grey.shade50,
      child: SizedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () => viewModel.updateQRViewType(QRWidgetViewType.qrView),
              child: Container(
                padding: EdgeInsets.only(
                  top: viewSize.fullHeightSafeArea * 0.007,
                ),
                width: viewSize.fullWidthSafeArea * 0.44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: qrViewType == QRWidgetViewType.qrView
                      ? HexColors.white
                      : HexColors.backgroundColor,
                ),
                child: const Center(
                  child: FittedBox(
                    child: Text(
                      "myQR",
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: ()=> viewModel.updateQRViewType(QRWidgetViewType.scanView),
              child: Container(
                padding: EdgeInsets.only(
                  top: viewSize.fullHeightSafeArea * 0.007,
                ),
                width: viewSize.fullWidthSafeArea * 0.45,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(viewSize.fullWidthSafeArea * 0.012),
                  color: qrViewType == QRWidgetViewType.scanView
                      ? HexColors.white
                      : HexColors.backgroundColor,
                ),
                child: const Center(
                  child: FittedBox(
                    child: Text(
                      "ReadQR",
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _textByScanResult(QRScanResult qrScanResult) {
    switch (qrScanResult) {
      case QRScanResult.idle:
      case QRScanResult.scanning:
      case QRScanResult.scanSuccess:
        return "Scan QR Code";
      case QRScanResult.scanFailure:
        return "QR Code Failed";
    }
  }

  @override
  void dispose() {
    LogUtils.i("$runtimeType disposed !!!");
    super.dispose();
  }
}
