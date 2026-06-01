import 'package:attendance_app/component/routes.dart';
import 'package:attendance_app/component/url.dart';
import 'package:attendance_app/main.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';

class DioClientInterceptor {
  static Dio createDio({bool includeChucker = true}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: Url.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 60),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (error, handler) {
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
              navigatorKey.currentState?.pushNamedAndRemoveUntil(
                Routes.login,
                (route) => false,
              );
              return handler.reject(error);

            case 402:
              return handler.reject(error);

            case 404:
              return handler.reject(error);

            default:
              return handler.reject(error);
          }
        },
      ),
    );

    if (includeChucker) {
      dio.interceptors.add(ChuckerDioInterceptor());
    }

    return dio;
  }
}
