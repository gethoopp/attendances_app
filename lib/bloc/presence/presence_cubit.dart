import 'package:attendance_app/bloc/base/base_state.dart';
import 'package:attendance_app/repository/presence/base_presence.dart';
import 'package:bloc/bloc.dart';

class PresenceCubit extends Cubit<DataState> {
  final BasePresence basePresence;
  PresenceCubit(this.basePresence) : super(DataInitial());

  void sendCheckIn(String token, int id) async {
    emit(DataLoading());
    try {
      var response = await basePresence.sendCheckIn(id, token);
      emit(DataSucces(response));
    } catch (e) {
      emit(DataError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  void sendCheckOut(String token, int id) async {
    emit(DataLoading());
    try {
      var response = await basePresence.sendCheckOut(id, token);
      emit(DataSucces(response));
    } catch (e) {
      emit(DataError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
