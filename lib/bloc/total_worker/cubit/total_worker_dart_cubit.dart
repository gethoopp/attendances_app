import 'package:attendance_app/bloc/base/base_state.dart';
import 'package:attendance_app/model/Total_data_worker/total_data_worker.dart';
import 'package:attendance_app/repository/total_worker/base_total_worker.dart';
import 'package:bloc/bloc.dart';

class TotalWorkerDartCubit extends Cubit<DataState<DataTotalWorker>> {
  final BasetotalDataworker basetotalDataworker;
  TotalWorkerDartCubit(this.basetotalDataworker) : super(DataInitial());

  Future<void> dataTotalWorker(int id, String token) async {
    try {
      final result = await basetotalDataworker.dataWorker(id, token);
      emit(DataSucces(result));
    } catch (e) {
      emit(DataError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
