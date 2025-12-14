import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../model/register_form/register_form.dart';

part 'register_form_state.dart';

class RegisterFormCubit extends Cubit<RegisterFormState<RegisterFormData>> {
  RegisterFormCubit() : super(RegisterFormInitial(RegisterFormData()));

  void initialize(RegisterFormData registerFormData) {
    emit(RegisterFormSuccess(registerFormData));
  }

  void onChangeUsername(RegisterFormData latestFormData, String username) {
    latestFormData = latestFormData.copyWith(firstName: username);
    emit(RegisterFormSuccess(latestFormData));
  }

  void onChangeDepartement(
      RegisterFormData latestFormData, String departement) {
    latestFormData = latestFormData.copyWith(departement: departement);
    emit(RegisterFormSuccess(latestFormData));
  }

  void onChangeEmail(RegisterFormData latestFormData, String email) {
    latestFormData = latestFormData.copyWith(email: email);
    emit(RegisterFormSuccess(latestFormData));
  }

  void onChangePassword(RegisterFormData latestFormData, String password) {
    latestFormData = latestFormData.copyWith(password: password);
    emit(RegisterFormSuccess(latestFormData));
  }

  void onChangeRfid(RegisterFormData latestFormData, int rfid) {
    latestFormData = latestFormData.copyWith(rfid: rfid);
    emit(RegisterFormSuccess(latestFormData));
  }

  void onTapShowPassword(RegisterFormData latestFormData, bool isShow) {
    latestFormData = latestFormData.copyWith(securePassword: !isShow);
    emit(RegisterFormSuccess(latestFormData));
  }
}
