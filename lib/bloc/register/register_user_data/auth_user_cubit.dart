import 'package:attendance_app/repository/users/users.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meta/meta.dart';

part 'auth_user_state.dart';

class AuthUserCubit extends Cubit<AuthUserState> {
  final BaseUserRepository userRepository;

  AuthUserCubit(this.userRepository) : super(AuthUserInitial());

  // Cubit untuk register user
  Future<dynamic> registerUser(
    BuildContext context, {
    required int cardNumber,
    required String firstName,
    required String lastName,
    required String department,
    required String email,
    required String password,
  }) async {
    emit(AuthUserLoading());
    try {
      final result = await userRepository.registerUserData(
          cardNumber, firstName, lastName, department, email, password);
      emit(AuthUserSucces(result));
    } catch (e) {
      emit(AuthUserErr(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  //Cubit untuk Login user

  Future<dynamic> loginUser({
    required String email,
    required String pass,
  }) async {
    emit(AuthUserLoading());
    try {
      final result = await userRepository.loginUser(email, pass);
      emit(AuthUserSucces(result));
    } catch (e) {
      emit(AuthUserErr(e.toString()));
    }
  }
}
