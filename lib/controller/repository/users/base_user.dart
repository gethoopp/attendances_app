abstract class BaseUserRepository {
  Future<void> getUserData(int id);
  Future<void> inputDataRfid();
  Future<dynamic> registerUserData(int cardNumber, String firstName,
      String lastName, String departement, String email, String pass);
}
