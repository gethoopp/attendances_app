import 'package:attendance_app/model/Total_data_worker/total_data_worker.dart';
import 'package:attendance_app/model/presence_data/presence_data.dart';

abstract class BasePresence {
  Future<String> sendCheckIn(int id, String token);
  Future<String> sendCheckOut(int id, String token);
  Future<DataPresence> getUserData(int id, String token, String date);
  Future<DataPresence> getUserByDate(int id, String token, String dateNow);
  Future<DataTotalWorker> getUserTotalData(int id, String token);
}
