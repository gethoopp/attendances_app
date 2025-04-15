import 'package:attendance_app/controller/repository/users/users.dart';
import 'package:dio/dio.dart';

class GetUserData implements BaseUserRepository {
  final dio = Dio();

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
      var result = await dio.post("http://192.168.1.21:8080/api/register",
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
      } else {
        return;
      }
    } catch (e) {
      print("Exception occurred: ${e.toString()}");
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
