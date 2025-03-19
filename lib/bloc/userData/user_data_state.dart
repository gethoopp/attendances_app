part of 'user_data_cubit.dart';

@immutable
sealed class UserDataState {}

final class UserDataInitial extends UserDataState {}


final class UserDataSucces extends UserDataState{}


final class UserDataErr extends UserDataState{}