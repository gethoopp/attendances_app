import 'package:attendance_app/model/Total_data_worker/total_data_worker.dart';

abstract class BasetotalDataworker {
  Future<DataTotalWorker> dataWorker(int id, String token);
}
