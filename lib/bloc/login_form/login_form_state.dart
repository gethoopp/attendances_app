// ignore_for_file: overridden_fields

part of 'login_form_cubit.dart';

sealed class LoginFormState<T> extends Equatable {
  final T? data;

  const LoginFormState({this.data});

  @override
  List<Object?> get props => [data];
}

final class LoginFormInitial<T> extends LoginFormState<T> {
  @override
  final T data;

  const LoginFormInitial(this.data) : super(data: data);

  @override
  List<Object?> get props => [data];
}

final class LoginErrorState<T> extends LoginFormState<T> {
  final String message;

  const LoginErrorState({required this.message, super.data});

  @override
  List<Object?> get props => [message, data];
}

final class LoginFormSuccess<T> extends LoginFormState<T> {
  const LoginFormSuccess(T? data) : super(data: data);

  @override
  List<Object?> get props => [data];
}
