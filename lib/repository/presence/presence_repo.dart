import 'package:attendance_app/component/url.dart';
import 'package:attendance_app/interceptor/dio_client_interceptor.dart';
import 'package:attendance_app/repository/presence/base_presence.dart';
import 'package:dio/dio.dart';

class CheckInRepository implements BasePresence {
  final dio = DioClientInterceptor.createDio();
  @override
  Future<String> sendCheckIn(int id, String token) async {
    try {
      var result = await dio.post(Url.sendCheckin,
          options: Options(headers: {"Authorization": "Bearer $token"}),
          data: {"id_users": id});

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
          throw Exception(
            e.response?.data['message'] ?? "Terjadi kesalahan",
          );
      }
    }
  }

  @override
  Future<String> sendCheckOut(int id, String token) async {
    try {
      var result = await dio.post(Url.sendCheckOut,
          options: Options(headers: {"Authorization": "Bearer $token"}),
          data: {"id_users": id});

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
          throw Exception(
            e.response?.data['message'] ?? "Terjadi kesalahan",
          );
      }
    }
  }
}
