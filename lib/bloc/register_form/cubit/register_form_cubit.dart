import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../model/register_form/register_form.dart';

part 'register_form_state.dart';

class RegisterFormCubit extends Cubit<RegisterFormState<RegisterFormData>> {
  RegisterFormCubit() : super(RegisterFormInitial(RegisterFormData()));

  void initialize(RegisterFormData registerFormData) {
    emit(RegisterFormSucces(registerFormData));
  }

  void onChangeFirstName(RegisterFormData latestFormData, String firstName) {
    latestFormData = latestFormData.copyWith(firstName: firstName);
    emit(RegisterFormSucces(latestFormData));
  }

  void onChangeLastName(RegisterFormData latestFormData, String lastName) {
    latestFormData = latestFormData.copyWith(lastName: lastName);
    emit(RegisterFormSucces(latestFormData));
  }

  void onChangeDepartement(
      RegisterFormData latestFormData, String departement) {
    latestFormData = latestFormData.copyWith(departement: departement);
    emit(RegisterFormSucces(latestFormData));
  }

  void onChangeEmail(RegisterFormData latestFormData, String email) {
    latestFormData = latestFormData.copyWith(email: email);
    emit(RegisterFormSucces(latestFormData));
  }

  void onChangePassword(RegisterFormData latestFormData, String password) {
    latestFormData = latestFormData.copyWith(password: password);
    emit(RegisterFormSucces(latestFormData));
  }

  void onChangeRfid(RegisterFormData latestFormData, int rfid) {
    latestFormData = latestFormData.copyWith(rfid: rfid);
    emit(RegisterFormSucces(latestFormData));
  }
}
