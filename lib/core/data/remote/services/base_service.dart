import 'dart:async';

import 'package:develop_app_hoangnm/core/data/remote/configs/app_dio.dart';
import 'package:develop_app_hoangnm/core/data/remote/configs/mock_api.dart';
import 'package:develop_app_hoangnm/core/utils/log_utils.dart';

/// API Request送信
abstract class BaseService {

  final MockAPIHelpers mockAPIHelpers = MockAPIHelpers();

  Future<T?> post<T>(
    // url represents end point
    String url, {
    Object? body,
    String? param,
    required T Function(Object?) mapper,
  }) async {
    Uri uri = AppDio().processUri(url: url, param: param);
    LogUtils.d('[$runtimeType][REQUEST:POST] API:【${uri.path}】 body:$body');
    return AppDio()
        .postUri<String>(
          uri,
          data: body,
        )
        .then(
          (response) => mapper.call(
            AppDio().convertResponseToObject(
              response,
              runtimeType.toString(),
              uri.path,
            ),
          ),
        );
  }

  Future<T?> put<T>(
    // url represents end point
    String url, {
    Object? body,
    String? param,
    required T Function(Object?) mapper,
    bool needAccessToken = true,
  }) async {
    Uri uri = AppDio().processUri(url: url, param: param);
    return AppDio()
        .putUri<String>(
          uri,
          data: body,
        )
        .then(
          (response) => mapper.call(
            AppDio().convertResponseToObject(
              response,
              runtimeType.toString(),
              uri.path,
            ),
          ),
        );
  }

  Future<T?> delete<T>(
    // url represents end point
    String url, {
    Object? body,
    String? param,
    required T Function(Object?) mapper,
  }) async {
    Uri uri = AppDio().processUri(url: url, param: param);
    return AppDio()
        .deleteUri<String>(
          uri,
          data: body,
        )
        .then(
          (response) => mapper.call(
            AppDio().convertResponseToObject(
              response,
              runtimeType.toString(),
              uri.path,
            ),
          ),
        );
  }

  Future<T?> get<T>(
    // url represents end point
    String url, {
    String? param,
    required T Function(Object?) mapper,
  }) async {
    Uri uri = AppDio().processUri(url: url, param: param);
    return AppDio()
        .getUri<String>(
          uri,
        )
        .then(
          (response) => mapper.call(
            AppDio().convertResponseToObject(
              response,
              runtimeType.toString(),
              uri.path,
            ),
          ),
        );
  }

  //ti xoa

  Future<T?> patch<T>(
      // url represents end point
      String url, {
        Object? body,
        String? param,
        required T Function(Object?) mapper,
        bool needAccessToken = true,
      }) async {
    Uri uri = AppDio().processUri(url: url, param: param);
    return AppDio()
        .patchUri<String>(
      uri,
      data: body,
    )
        .then(
          (response) => mapper.call(
        AppDio().convertResponseToObject(
          response,
          runtimeType.toString(),
          uri.path,
        ),
      ),
    );
  }

}
