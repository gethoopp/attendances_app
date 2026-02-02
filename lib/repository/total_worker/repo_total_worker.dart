import 'package:attendance_app/component/url.dart';
import 'package:attendance_app/interceptor/dio_client_interceptor.dart';
import 'package:attendance_app/model/Total_data_worker/total_data_worker.dart';
import 'package:attendance_app/repository/total_worker/base_total_worker.dart';
import 'package:dio/dio.dart';

class BaseTotalWorker implements BasetotalDataworker {
  final dio = DioClientInterceptor.createDio();

  @override
  Future<DataTotalWorker> dataWorker(int id, String token) async {
    try {
      final result = await dio.get(
        Url.getTotalData,
        options: Options(headers: {"Authorization": "Bearer $token"}),
        queryParameters: {"id_user": id},
      );

      return DataTotalWorker.fromJson(result.data);
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
            e.response?.data['message'] ?? "Terjadi kesalahan bos",
          );
      }
    }
  }
}
