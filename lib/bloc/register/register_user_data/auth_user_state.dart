part of 'auth_user_cubit.dart';

@immutable
sealed class AuthUserState {}

final class AuthUserInitial extends AuthUserState {}

final class AuthUserSucces extends AuthUserState {
  final String data;
  AuthUserSucces(this.data);

  List<Object> get props => [data];
}

final class AuthUserLoading extends AuthUserState {}

final class AuthUserErr extends AuthUserState {
  final String message;
  AuthUserErr(this.message);
}

final class RegisterAuthSucces extends AuthUserState {
  final User data;
  RegisterAuthSucces(this.data);

  List<Object> get propos => [data];
}

final class RegisterAuthLoading extends AuthUserState {}
