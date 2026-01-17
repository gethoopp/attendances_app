import 'package:attendance_app/model/presence_data/presence_data.dart';

abstract class BasePresence {
  Future<String> sendCheckIn(int id, String token);
  Future<String> sendCheckOut(int id, String token);
  Future<DataPresence> getUserData(int id, String token);
  Future<DataPresence> getUserByDate(int id, String token, DateTime dateNow);
}
