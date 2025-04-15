import 'package:attendance_app/controller/repository/users/users.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'register_user_state.dart';

class RegisterUserCubit extends Cubit<RegisterUserState> {
  RegisterUserCubit(this.userRepository) : super(RegisterUserInitial());
  final BaseUserRepository userRepository;

  Future<dynamic> registerUser(int cardNumber, String firstName,
      String lastName, String departement, String email, String pass) async {
    try {
      final response = await userRepository.registerUserData(
        cardNumber,
        firstName,
        lastName,
        departement,
        email,
        pass,
      );

      emit(RegisterUserSucces(response));
    } catch (e) {
      emit(RegisterUserError(e.toString()));
    }
  }
}
