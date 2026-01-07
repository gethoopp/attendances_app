import 'package:equatable/equatable.dart';

sealed class PresenceState<T> extends Equatable {
  final T? data;
  final String? message;

  const PresenceState({this.data, this.message});

  @override
  List<Object?> get props => [data, message];
}

final class PresenceInitial<T> extends PresenceState<T> {
  const PresenceInitial();
}

final class PresenceLoading<T> extends PresenceState<T> {
  const PresenceLoading({T? data}) : super(data: data);
}

final class PresenceSuccess<T> extends PresenceState<T> {
  const PresenceSuccess(T data, {String? message})
      : super(data: data, message: message);
}

final class PresenceError<T> extends PresenceState<T> {
  const PresenceError(String message, {T? data})
      : super(message: message, data: data);
}
