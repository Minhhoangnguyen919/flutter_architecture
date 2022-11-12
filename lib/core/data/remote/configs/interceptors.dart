import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:develop_app_hoangnm/core/data/models/user_model.dart';
import 'package:develop_app_hoangnm/core/data/remote/api/api_exception.dart';
import 'package:develop_app_hoangnm/core/data/remote/api/failure.dart';
import 'package:develop_app_hoangnm/core/data/share_preference/spref_user_model.dart';
import 'package:develop_app_hoangnm/core/utils/log_utils.dart';
import 'package:dio/dio.dart';

import 'app_dio.dart';

class HandleInterceptors extends QueuedInterceptorsWrapper {
  final AppDio appDio;

  HandleInterceptors(this.appDio);

  //TODO header
  Map<String, String> get headers {
    return <String, String>{
      'Accept': '*/*',
    };
  }

  Map<String, String> get authorizedHeaders {
    final String accessToken = SPrefUserModel().getAccessToken() ?? "";
    return headers..putIfAbsent('Authorization', () => "Bearer $accessToken");

  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    final path = err.requestOptions.path;
    final statusCode = err.response?.statusCode;
    final bodyFailure = err.response?.data?.toString() ?? "";
    LogUtils.d("【API:ERROR/$statusCode】【$path】【$bodyFailure】 $err");
    if (_isNetworkError(err)) {
      LogUtils.d("【interceptor:error】【$path】 network error ...");
      handler.reject(NoInternetException(err.requestOptions, null));
      return;
    }
    if (_isTimeoutException(err)) {
      LogUtils.d("【interceptor:error】【$path】 timeout error ...");
      // Retry api
      handler.reject(AppTimeOutException(err.requestOptions,
          Failure(errorCode: 500, message: "Error internet")));
    }
    dynamic responseJson = jsonDecode(bodyFailure == "" ? "{}" : bodyFailure);
    Failure? failure = Failure.fromJson(
      responseJson,
    );
    if (statusCode != null) {
      switch (statusCode) {
        case 400:
          handler.reject(BadRequestException(err.requestOptions, failure));
          break;
        case 401:
          //TODO retry login
          // if (path ==
          //     appDio.processUri(url: ApiEndPointConstants.signIn).toString()) {
          //   /// Because API called don't need retry
          //   LogUtils.d("[$path] throws UnauthorisedException...");
          //   handler.reject(UnauthorisedException(err.requestOptions, failure));
          //   return;
          // }
          await _processRefreshToken(err, handler);
          break;
        case 403:
          handler.reject(ForbiddenException(err.requestOptions, failure));
          break;
        case 500:
          handler.reject(FetchDataException(err.requestOptions, failure));
          break;
        case 504:
          handler.reject(ServerTimeOutException(err.requestOptions, failure));
          break;
        case 503:
          handler
              .reject(ServerUnavailableException(err.requestOptions, failure));
          break;
        default:
          handler.next(err);
          break;
      }
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    LogUtils.d("onRequest -> [options.path] => ${options.path}");
    // if (options.path == appDio.processUri(url:  ApiEndPointConstants.login).toString()) {
    if (options.path.contains("authenticate")) {
      /// Because API called is login api -> unnecessary retry handler
      options.headers = headers;
    } else {
      options.headers = authorizedHeaders;
    }
    super.onRequest(options, handler);
  }

  Future<void> _processRefreshToken(
      DioError err, ErrorInterceptorHandler handler,
      {int retryCount = 1}) async {
    LogUtils.d("【retryCount】 => $retryCount");

    /// Others API handlers ...
    /// API Response(401:UnAuthorized) 送信
    LogUtils.d("【_processRefreshToken:retry】");
    RequestOptions requestOptions = err.response!.requestOptions;

    /// ログイン処理 Request送信
    await _refreshAccessToken().then((newUser) async {
      /// [200:OK]
      /// ログイン処理 Response送信
      /// accessToken取得
      /// 登録結果

      if (newUser != null) {
        SPrefUserModel().setAccessToken(newUser.accessToken);
        SPrefUserModel().setRefreshToken(newUser.refreshToken);
        SPrefUserModel().setExpiration(newUser.expiration);
        SPrefUserModel().setExpires(newUser.expires);
      }
      LogUtils.d(
          "【interceptor:retry】【${err.requestOptions.uri.path}】[$retryCount] has new token");
      // Repeat call api ...
      await appDio.fetch<dynamic>(requestOptions).then((r) {
        handler.resolve(r);
      }).onError<DioError>((error, stackTrace) {
        handler.reject(error);
      });
    }).onError<DioError>((errorRefreshToken, stackTrace) async {
      LogUtils.d(
          "【interceptor:refresh_token:error】【${err.requestOptions.uri.path}】[$retryCount] refresh token has error $errorRefreshToken");
      // 400が返却された場合、エラーダイアログ①「異常が発生しています」というダイアログを表示する
      if (errorRefreshToken is BadRequestException) {
        handler.reject(LoginTimeoutBadRequestException(
          errorRefreshToken.requestOptions,
          errorRefreshToken.failure,
        ));
        return;
      } else if (errorRefreshToken is UnauthorisedException) {
        if (retryCount > 1) {
          handler.reject(errorRefreshToken);
          return;
        } else {
          /// 401 refreshToken
          await _processRefreshToken(err, handler, retryCount: 2);
          return;
        }
      } else {
        handler.reject(errorRefreshToken);
        return;
      }
    });
  }

  Future<UserModel?> _refreshAccessToken() async {
    await SPrefUserModel().onInit();
    final String? accessToken = SPrefUserModel().getAccessToken();
    final String? refreshToken = SPrefUserModel().getRefreshToken();
    Uri uri =
        appDio.processUri(url: "", param: null);
    final body = {"accessToken": accessToken, "refreshToken": refreshToken};
    LogUtils.d(
        '[$runtimeType][REQUEST:POST][REFRESH_TOKEN] API:【${uri.path}】 body:$body');
    return appDio
        .postUri<String>(
          uri,
          data: body,
        )
        .then((response) => UserModel.fromJson(appDio.convertResponseToObject(
                response, runtimeType.toString(), uri.path)
            as Map<String, dynamic>));
  }

  bool _isNetworkError(DioError err) {
    return err.error != null &&
        (err.error is SocketException || err.error is HttpException);
  }

  bool _isTimeoutException(DioError err) {
    return err.type == DioErrorType.sendTimeout ||
        err.type == DioErrorType.connectTimeout ||
        err.type == DioErrorType.receiveTimeout;
  }
}
