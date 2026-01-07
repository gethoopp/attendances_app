import 'package:attendance_app/bloc/base/base_state.dart';
import 'package:attendance_app/repository/presence/base_presence.dart';
import 'package:bloc/bloc.dart';

class PresenceCubit extends Cubit<PresenceState> {
  final BasePresence basePresence;
  PresenceCubit(this.basePresence) : super(PresenceInitial());

  void sendCheckIn(String token, int id) async {
    emit(PresenceLoading());
    try {
      var response = await basePresence.sendCheckIn(id, token);
      emit(PresenceSuccess(response));
    } catch (e) {
      emit(PresenceError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  void sendCheckOut(String token, int id) async {
    emit(PresenceLoading());
    try {
      var response = await basePresence.sendCheckOut(id, token);
      emit(PresenceSuccess(response));
    } catch (e) {
      emit(PresenceError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
