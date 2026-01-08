import 'package:equatable/equatable.dart';

sealed class DataState<T> extends Equatable {
  final T? data;
  final String? message;

  const DataState({this.data, this.message});

  @override
  List<Object?> get props => [data, message];
}

final class DataInitial<T> extends DataState<T> {
  const DataInitial();
}

final class DataLoading<T> extends DataState<T> {
  const DataLoading({T? data}) : super(data: data);
}

final class DataSucces<T> extends DataState<T> {
  const DataSucces(T data, {String? message})
      : super(data: data, message: message);
}

final class DataError<T> extends DataState<T> {
  const DataError(String message, {T? data})
      : super(message: message, data: data);
}
