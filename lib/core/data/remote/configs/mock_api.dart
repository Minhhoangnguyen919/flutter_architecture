import 'package:develop_app_hoangnm/core/utils/log_utils.dart';
import 'package:develop_app_hoangnm/ui/widgets/banners/flavor_config.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'app_dio.dart';

/// Developers with mock api for testing ...
class MockAPIHelpers {
  /// You need test API with mock response we can set true.
  bool hasMockAPI = FlavorConfig.instance!.hasMockAPI;

  DioAdapter? _mockDioAdapter;

  static MockAPIHelpers? _instance;

  MockAPIHelpers._();

  factory MockAPIHelpers() => _instance ??= MockAPIHelpers._();

  void setMockAdapter(DioAdapter adapter) {
    _mockDioAdapter = adapter;
  }

  void mockPOST_200({
    required String url,
    String? param,
    dynamic body,
    dynamic jsonResponse = const {'message': 'Success!'},
  }) {
    if (!hasMockAPI) return;
    LogUtils.d("[MOCK:REQUEST][POST][200] $url");
    Uri uri = AppDio().processUri(url: url, param: param);
    _mockDioAdapter?.onPost(
      uri.toString(),
      (server) => server.reply(
        200,
        jsonResponse,
        // Reply would wait for one-sec before returning data.
        delay: const Duration(seconds: 1),
      ),
      data: body,
    );
  }

  void mockGET_200({
    required String url,
    String? param,
    dynamic body,
    dynamic jsonResponse = const {'message': 'Success!'},
  }) {
    if (!hasMockAPI) return;
    LogUtils.d("[MOCK:REQUEST][GET][200] $url");
    Uri uri = AppDio().processUri(url: url, param: param);
    _mockDioAdapter?.onGet(
      uri.toString(),
      (server) => server.reply(
        200,
        jsonResponse,
        // Reply would wait for one-sec before returning data.
        delay: const Duration(seconds: 1),
      ),
      data: body,
    );
  }

  void mockPUT_200({
    required String url,
    String? param,
    dynamic body,
    dynamic jsonResponse = const {'message': 'Success!'},
  }) {
    if (!hasMockAPI) return;
    LogUtils.d("[MOCK:REQUEST][GET][200] $url");
    Uri uri = AppDio().processUri(url: url, param: param);
    _mockDioAdapter?.onPut(
      uri.toString(),
      (server) => server.reply(
        200,
        jsonResponse,
        // Reply would wait for one-sec before returning data.
        delay: const Duration(seconds: 1),
      ),
      data: body,
    );
  }

  void mockDELETE_200({
    required String url,
    String? param,
    dynamic body,
    dynamic jsonResponse = const {'message': 'Success!'},
  }) {
    if (!hasMockAPI) return;
    LogUtils.d("[MOCK:REQUEST][GET][200] $url");
    Uri uri = AppDio().processUri(url: url, param: param);
    _mockDioAdapter?.onDelete(
      uri.toString(),
      (server) => server.reply(
        200,
        jsonResponse,
        // Reply would wait for one-sec before returning data.
        delay: const Duration(seconds: 1),
      ),
      data: body,
    );
  }

  void mockPOST_400({
    required String url,
    String? param,
    dynamic body,
    dynamic jsonResponse = const {
      'error': {'message': 'Mock api error !!!', 'code': '999'},
    },
  }) {
    if (!hasMockAPI) return;
    LogUtils.d("[MOCK:REQUEST][POST][400] $url");
    Uri uri = AppDio().processUri(url: url, param: param);
    _mockDioAdapter?.onPost(
      uri.toString(),
      (server) => server.reply(
        400,
        jsonResponse,
        // Reply would wait for one-sec before returning data.
        delay: const Duration(seconds: 1),
      ),
      data: body,
    );
  }

  void mockPOST_401({
    required String url,
    String? param,
    dynamic body,
  }) {
    if (!hasMockAPI) return;
    LogUtils.d("[MOCK:REQUEST][POST][401] $url");
    Uri uri = AppDio().processUri(url: url, param: param);
    _mockDioAdapter?.onPost(
      uri.toString(),
      (server) => server.reply(
        401,
        null,
        // Reply would wait for one-sec before returning data.
        delay: const Duration(seconds: 1),
      ),
      data: body,
    );
  }

  void mockGET_401({
    required String url,
    String? param,
    dynamic body,
  }) {
    if (!hasMockAPI) return;
    LogUtils.d("[MOCK:REQUEST][GET][401] $url");
    Uri uri = AppDio().processUri(url: url, param: param);
    _mockDioAdapter?.onGet(
      uri.toString(),
      (server) => server.reply(
        401,
        null,
        // Reply would wait for one-sec before returning data.
        delay: const Duration(seconds: 1),
      ),
      data: body,
    );
  }
}
