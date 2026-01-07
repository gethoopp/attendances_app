abstract class BasePresence {
  Future<String> sendCheckIn(int id, String token);
  Future<String> sendCheckOut(int id, String token);
}
