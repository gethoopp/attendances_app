import 'package:attendance_app/model/users_data/user.dart';

abstract class BaseUserRepository {
  Future<User> getUserData(int id, String token);
  Future<void> inputDataRfid();
  Future<String> registerUserData(int cardNumber, String firstName,
      String lastName, String departement, String email, String pass);

  Future<User> loginUser(String email, String pass);
}
