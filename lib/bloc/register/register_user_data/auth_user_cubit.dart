import 'package:attendance_app/model/users_data/user.dart';
import 'package:attendance_app/repository/users/users.dart';
import 'package:bloc/bloc.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';

part 'auth_user_state.dart';

class AuthUserCubit extends Cubit<AuthUserState> {
  final BaseUserRepository userRepository;
  AuthUserCubit(this.userRepository) : super(AuthUserInitial());

  // Cubit untuk register user
  void registerUser({
    required String firstName,
    required String lastName,
    required String department,
    required String email,
    required String password,
    required int rfid,
  }) async {
    emit(AuthUserLoading());
    try {
      final result = await userRepository.registerUserData(
        rfid,
        firstName,
        lastName,
        department,
        email,
        password,
      );
      emit(AuthUserSucces(result));
    } catch (e) {
      emit(AuthUserErr(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  //Cubit untuk Login user
  void loginUser({required String email, required String pass}) async {
    emit(RegisterAuthLoading());
    final result = await userRepository.loginUser(email, pass);
    return result.fold(
      ifRight: (value) => emit(RegisterAuthSucces(value)),
      ifLeft: (value) =>
          emit(AuthUserErr(value.toString().replaceFirst('Exception: ', ''))),
    );
  }

  Future<void> getUser(int id, String token) async {
    emit(RegisterAuthLoading());
    try {
      final user = await userRepository.getUserData(
        id,
        token,
      ); // dari API / local
      emit(RegisterAuthSucces(user));
    } catch (e) {
      emit(AuthUserErr(toString().replaceFirst('Exception: ', '')));
    }
  }
}
