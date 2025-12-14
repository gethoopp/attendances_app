import 'package:attendance_app/component/url.dart';
import 'package:attendance_app/repository/users/users.dart';
import 'package:dio/dio.dart';

class GetUserData implements BaseUserRepository {
  final dio =
      Dio(BaseOptions(baseUrl: Url.baseUrl, sendTimeout: Duration(seconds: 2)));

  @override
  Future<void> getUserData(int id) {
    throw UnimplementedError();
  }

  @override
  Future<void> inputDataRfid() {
    throw UnimplementedError();
  }

  @override
  Future<void> registerUserData(int cardNumber, String firstName,
      String lastName, String departement, String email, String pass) async {
    try {
      var result = await dio.post(Url.registerUrl,
          data: {
            "rfid_id": cardNumber,
            "id_first_name": firstName,
            "id_last_name": lastName,
            "id_departement": departement,
            "email_user": email,
            "password_user": pass
          },
          options: Options(
            contentType: 'application/json',
          ));

      if (result.statusCode == 200) {
        return result.data["Message"];
      } else if (result.statusCode != null && result.statusCode! >= 500) {
        throw Exception(result.data['message']);
      } else if (result.statusCode != null && result.statusCode! < 500) {
        throw Exception(result.data['message']);
      }
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode ?? 0;
      if (statusCode >= 500) {
        throw Exception(e.response?.data["message"]);
      } else if (statusCode < 500) {
        throw Exception(e.response?.data['message']);
      } else {
        throw Exception(e.response?.data['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> loginUser(String email, String pass) async {
    try {
      var response = await dio.post("http://192.168.1.21:8080/api/login",
          data: {
            "email_user": email,
            "password_user": pass,
          },
          options: Options(
            contentType: 'application/json',
          ));

      return response.data["token"];
    } catch (e) {}
  }
}
