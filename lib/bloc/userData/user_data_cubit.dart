import 'package:attendance_app/repository/users/users.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(UserDataInitial());

  //cubit untuk memanggil data user berdasarkan id
  void userGetData(int id) async{
    final BaseUserRepository userRepository;

    try {
      // final reesult = userRepository.getUserData();
    } catch (e) {

    }
  }
}
