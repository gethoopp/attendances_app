import 'package:attendance_app/component/routes.dart';
import 'package:attendance_app/component/url.dart';
import 'package:attendance_app/interceptor/dio_client_interceptor.dart';
import 'package:attendance_app/main.dart';
import 'package:attendance_app/model/presence_data/presence_data.dart';
import 'package:attendance_app/repository/presence/base_presence.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CheckInRepository implements BasePresence {
  final dio = DioClientInterceptor.createDio();
  @override
  Future<String> sendCheckIn(int id, String token) async {
    try {
      var result = await dio.post(
        Url.sendCheckin,
        options: Options(headers: {"Authorization": "Bearer $token"}),
        data: {"user_id": id},
      );

      return result.data['message'];
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 401:
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
            Routes.login,
            (route) => false,
          );
          throw Exception(e.response?.data['message']);
        case 404:
          throw Exception(e.response?.data['message']);
        case 402:
          throw Exception(e.response?.data['message']);
        case 500:
          throw Exception(e.response?.data['message']);
        case 409:
          throw Exception(e.response?.data['message']);
        default:
          throw Exception(e.response?.data['message'] ?? "Terjadi kesalahan");
      }
    }
  }

  @override
  Future<String> sendCheckOut(int id, String token) async {
    try {
      var result = await dio.put(
        Url.sendCheckOut,
        options: Options(headers: {"Authorization": "Bearer $token"}),
        data: {"user_id": id},
      );

      return result.data['message'];
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 404:
          throw Exception(e.response?.data['message']);
        case 402:
          throw Exception(e.response?.data['message']);
        case 500:
          throw Exception(e.response?.data['message']);
        case 409:
          throw Exception(e.response?.data['message']);
        default:
          throw Exception(e.response?.data['message'] ?? "Terjadi kesalahan");
      }
    }
  }

  @override
  Future<DataPresence> getUserData(int id, String token) async {
    try {
      final result = await dio.get(
        Url.getUserPresence,
        options: Options(headers: {"Authorization": "Bearer $token"}),
        queryParameters: {"id_user": id},
      );
      debugPrint("in hasil response ${result.data}");
      return DataPresence.fromJson(result.data);
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 404:
          throw Exception(e.response?.data['message']);
        case 402:
          throw Exception(e.response?.data['message']);
        case 500:
          throw Exception(e.response?.data['message']);
        case 409:
          throw Exception(e.response?.data['message']);
        default:
          throw Exception(e.response?.data['message'] ?? "Terjadi kesalahan");
      }
    }
  }

  @override
  Future<DataPresence> getUserByDate(
    int id,
    String token,
    DateTime dateByNow,
  ) async {
    try {
      final result = await dio.post(
        Url.getUserPresence,
        options: Options(headers: {"Authorization": "Bearer $token"}),
        data: {"user_id": id, "attendance_date": dateByNow},
      );
      debugPrint("in hasil response ${result.data}");
      return DataPresence.fromJson(result.data);
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 404:
          throw Exception(e.response?.data['message']);
        case 402:
          throw Exception(e.response?.data['message']);
        case 500:
          throw Exception(e.response?.data['message']);
        case 409:
          throw Exception(e.response?.data['message']);
        default:
          throw Exception(e.response?.data['message'] ?? "Terjadi kesalahan");
      }
    }
  }
}
