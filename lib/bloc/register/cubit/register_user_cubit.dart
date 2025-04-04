import 'package:attendance_app/controller/repository/users/base_user.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'register_user_state.dart';

class RegisterUserCubit extends Cubit<RegisterUserState> {
  final BaseUserRepository userRepository;

  RegisterUserCubit(this.userRepository) : super(RegisterUserInitial());

  // Cubit untuk register user
  Future<dynamic> registerUser({
    required int cardNumber,
    required String firstName,
    required String lastName,
    required String department,
    required String email,
    required String password,
  }) async {
    emit(RegisterUserInitial());
    try {
      final result = await userRepository.registerUserData(
          cardNumber, firstName, lastName, department, email, password);
      emit(RegisterUserSucces(result));
    } catch (e) {
      emit(RegisterUserErr(e.toString()));
    }
  }
}
