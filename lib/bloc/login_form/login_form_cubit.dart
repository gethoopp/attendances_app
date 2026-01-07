import 'package:attendance_app/model/login_form/login_form.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_form_state.dart';

class LoginFormCubit extends Cubit<LoginFormState<LoginFormData>> {
  LoginFormCubit() : super(LoginFormInitial(LoginFormData()));

  void initialize(LoginFormData loginFormData) {
    emit(LoginFormSuccess(loginFormData));
  }

  void onChangeUsername(LoginFormData latestFormData, String username) {
    latestFormData = latestFormData.copyWith(username: username);
    emit(LoginFormSuccess(latestFormData));
  }

  void onChangePassword(LoginFormData latestFormData, String password) {
    latestFormData = latestFormData.copyWith(password: password);
    emit(LoginFormSuccess(latestFormData));
  }

  void onTapShowPassword(LoginFormData latestFormData, bool isShow) {
    latestFormData = latestFormData.copyWith(securePassword: !isShow);
    emit(LoginFormSuccess(latestFormData));
  }
}
