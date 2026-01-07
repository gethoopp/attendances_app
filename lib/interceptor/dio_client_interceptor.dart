import 'package:attendance_app/component/routes.dart';
import 'package:attendance_app/component/url.dart';
import 'package:attendance_app/main.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';

class DioClientInterceptor {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: Url.baseUrl,
        sendTimeout: Duration(seconds: 2),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        validateStatus: (status) => true,
      ),
    );

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (error, handler) {
        final message =
            error.response?.data?['message'] ?? 'Terjadi kesalahan pada server';

        if (error.response?.statusCode != null &&
            error.response!.statusCode! >= 500) {
          return handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              error: 'Server sedang bermasalah',
            ),
          );
        }
        switch (error.response?.statusCode) {
          case 401:
            // auth error (logout / refresh token)
            navigatorKey.currentState
                ?.pushNamedAndRemoveUntil(Routes.login, (route) => false);
            break;

          case 402:
            return handler.reject(
              DioException(
                requestOptions: error.requestOptions,
                error: 'Coba Sesaat Lagi',
              ),
            );

          case 404:
            return handler.reject(
              DioException(
                requestOptions: error.requestOptions,
                error: 'Data tidak ditemukan',
              ),
            );

          default:
            return handler.reject(
              DioException(
                  requestOptions: error.requestOptions, error: message),
            );
        }
      },
    ));

    dio.interceptors.add(ChuckerDioInterceptor());

    return dio;
  }
}
