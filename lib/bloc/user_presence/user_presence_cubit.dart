import 'package:attendance_app/bloc/base/base_state.dart';
import 'package:attendance_app/model/presence_data/presence_data.dart';
import 'package:attendance_app/repository/presence/base_presence.dart';
import 'package:bloc/bloc.dart';

class UserPresenceCubit extends Cubit<DataState<DataPresence>> {
  final BasePresence basePresence;
  UserPresenceCubit(this.basePresence) : super(DataInitial());

  Future<void> getUserPresence(String token, int id, String date) async {
    emit(DataLoading());
    try {
      var response = await basePresence.getUserData(id, token, date);
      emit(DataSucces(response));
    } catch (e) {
      emit(DataError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> getUserByDate(String token, int id, String dateByNow) async {
    try {
      var response = await basePresence.getUserByDate(id, token, dateByNow);
      emit(DataSucces(response));
    } catch (e) {
      emit(DataError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
