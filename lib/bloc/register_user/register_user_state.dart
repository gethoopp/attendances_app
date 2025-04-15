part of 'register_user_cubit.dart';

@immutable
sealed class RegisterUserState {}

final class RegisterUserInitial extends RegisterUserState {}

final class RegisterUserSucces extends RegisterUserState {
  final String message;
  RegisterUserSucces(this.message);
}

final class RegisterUserError extends RegisterUserState {
  final String message;
  RegisterUserError(this.message);
}
