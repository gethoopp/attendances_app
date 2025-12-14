part of 'auth_user_cubit.dart';

@immutable
sealed class AuthUserState {}

final class AuthUserInitial extends AuthUserState {}

final class AuthUserSucces extends AuthUserState {
  final dynamic data;
  AuthUserSucces(this.data);

  List<Object> get props => [data];
}

final class AuthUserLoading extends AuthUserState {}

final class AuthUserErr extends AuthUserState {
  final String message;
  AuthUserErr(this.message);
}
