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
  const DataLoading({super.data});
}

final class DataSucces<T> extends DataState<T> {
  const DataSucces(T data, {super.message}) : super(data: data);
}

final class DataError<T> extends DataState<T> {
  const DataError(String message, {super.data}) : super(message: message);
}
