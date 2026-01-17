import 'package:attendance_app/component/url.dart';
import 'package:attendance_app/interceptor/dio_client_interceptor.dart';
import 'package:attendance_app/model/users_data/user.dart';
import 'package:attendance_app/repository/users/users.dart';
import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';

class GetUserData implements BaseUserRepository {
  final dio = DioClientInterceptor.createDio();

  @override
  Future<User> getUserData(int id, String token) async {
    try {
      var result = await dio.get(
        Url.getUser,
        options: Options(headers: {"Authorization": "Bearer $token"}),
        queryParameters: {"id_users": id},
      );

      return User.fromJson(result.data);
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
  Future<void> inputDataRfid() {
    throw UnimplementedError();
  }

  @override
  Future<String> registerUserData(
    int cardNumber,
    String firstName,
    String lastName,
    String departement,
    String email,
    String pass,
  ) async {
    try {
      var result = await dio.post(
        Url.registerUrl,
        data: {
          "rfid_id": cardNumber,
          "id_first_name": firstName,
          "id_last_name": lastName,
          "id_departement": departement,
          "email_user": email,
          "password_user": pass,
        },
      );

      return result.data["message"];
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
  Future<Either<String, User>> loginUser(String email, String pass) async {
    try {
      var response = await dio.post(
        Url.loginUrl,
        data: {"email_user": email, "password_user": pass},
      );

      return Right<String, User>(User.fromJson(response.data));
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 404:
          return Left<String, User>(e.response?.data['message']);
        case 402:
          return Left<String, User>(e.response?.data['message']);
        case 500:
          return Left<String, User>(e.response?.data['message']);
        default:
          return Left<String, User>(
            e.response?.data['message'] ?? "Terjadi Kesalahan",
          );
      }
    }
  }
}
