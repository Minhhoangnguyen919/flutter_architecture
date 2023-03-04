import 'package:develop_app_hoangnm/conponent/base_view/base_view_model.dart';
import 'package:develop_app_hoangnm/core/data/models/qr_model.dart';
import 'package:develop_app_hoangnm/core/enums/enums.dart';
import 'package:develop_app_hoangnm/core/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class SearchViewModel extends BaseViewModel {

  QRWidgetViewType _qrViewType = QRWidgetViewType.qrView;

  QRWidgetViewType get qrViewType => _qrViewType;

  String? get urlJsonQrCode => QRCodeModel().urlJsonQrCode ?? "";

  QRViewController? _qrController;

  QRScanResult _scanDataResult = QRScanResult.idle;

  QRScanResult get scanDataResult => _scanDataResult;

  void onQRViewCreated(QRViewController controller) {
    _qrController = controller;
    _qrController?.scannedDataStream.listen(
      (scanData) {
        if (_scanDataResult == QRScanResult.idle) {
          _onHandleAddDataScan(scanData.code);
        }
      },
    );
  }

  void onQRViewPermissionSet(QRViewController controller, bool hasPermission) {
    if (!hasPermission) {
      // Camera permission denied
      _scanDataResult = QRScanResult.scanFailure;
      updateUI();
      //Show dialog request permissionn
    } else {

    }
  }

  void updateQRViewType(QRWidgetViewType viewType) {
    if (qrViewType == viewType) return;
    _qrViewType = viewType;
    if (viewType == QRWidgetViewType.qrView) {
      _qrController?.stopCamera();
    } else {
      _scanDataResult = QRScanResult.idle;
      _qrController?.resumeCamera();
    }
    updateUI();
  }

  Future<void> _onHandleAddDataScan(String? body) async {
    if (urlJsonQrCode == null || body == null) return;
    final userName = QRCodeModel().getUserNameFromJson(body);
    LogUtils.d(
        "[_onHandleAddFriend] => friendTokenData: $urlJsonQrCode, resultScan: $body, userName: $userName");
    if (userName == null) {
      _scanDataResult = QRScanResult.idle;
      _showMyDialog("null");
      return;
    }
    _scanDataResult = QRScanResult.scanning;
    setLoading(isShow: true);
    updateUI();
    _showMyDialog(userName);
  }

  Future<void> _showMyDialog(String? body) async {
    _qrController?.stopCamera();
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text('$body'),
            // content: SingleChildScrollView(
          //   child: ListBody(
          //     children: <Widget>[
          //       Image.network(
          //         body ?? "",
          //         width: 300,
          //         height: 300,
          //       )
          //     ],
          //   ),
          // ),
          actions: <Widget>[
            TextButton(
              child: const Text('close dialog'),
              onPressed: () {
                _qrController?.resumeCamera();
                _scanDataResult = QRScanResult.idle;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _qrController?.stopCamera();
    super.dispose();
  }
}
