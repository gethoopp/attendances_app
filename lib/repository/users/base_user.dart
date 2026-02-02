import 'package:attendance_app/model/users_data/user.dart';
import 'package:dart_either/dart_either.dart';

abstract class BaseUserRepository {
  Future<User> getUserData(int id, String token);
  Future<void> inputDataRfid();
  Future<String> registerUserData(
    int cardNumber,
    String firstName,
    String lastName,
    String departement,
    String email,
    String pass,
  );

  Future<Either<String, User>> loginUser(String email, String pass);
}
