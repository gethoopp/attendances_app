part of 'register_user_cubit.dart';

@immutable
sealed class RegisterUserState {}

final class RegisterUserInitial extends RegisterUserState {}

final class RegisterUserSucces extends RegisterUserState {
  final dynamic data;
  RegisterUserSucces(this.data);

  List<Object> get props => [data];
}

final class RegisterUserErr extends RegisterUserState {
  final String message;
  RegisterUserErr(this.message);
}
