import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'presence_data.g.dart';

@JsonSerializable()
class DataPresence extends Equatable {
  final String message;
  final ResultPresence result;
  final int status;

  const DataPresence({
    required this.message,
    required this.result,
    required this.status,
  });

  DataPresence copyWith({
    String? message,
    ResultPresence? result,
    int? status,
  }) => DataPresence(
    message: message ?? this.message,
    result: result ?? this.result,
    status: status ?? this.status,
  );

  factory DataPresence.fromJson(Map<String, dynamic> json) =>
      _$DataPresenceFromJson(json);

  Map<String, dynamic> toJson() => _$DataPresenceToJson(this);

  @override
  List<Object?> get props => [message, result, status];
}

@JsonSerializable()
class ResultPresence extends Equatable {
  final int idAttendance;
  final int userId;
  final DateTime checkIn;
  final DateTime? checkOut;
  final DateTime attendanceDate;
  final String status;
  final DateTime createdAt;

  const ResultPresence({
    required this.idAttendance,
    required this.userId,
    required this.checkIn,
    this.checkOut,
    required this.attendanceDate,
    required this.status,
    required this.createdAt,
  });

  ResultPresence copyWith({
    int? idAttendance,
    int? userId,
    DateTime? checkIn,
    DateTime? checkOut,
    DateTime? attendanceDate,
    String? status,
    DateTime? createdAt,
  }) => ResultPresence(
    idAttendance: idAttendance ?? this.idAttendance,
    userId: userId ?? this.userId,
    checkIn: checkIn ?? this.checkIn,
    checkOut: checkOut ?? this.checkOut,
    attendanceDate: attendanceDate ?? this.attendanceDate,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
  );

  factory ResultPresence.fromJson(Map<String, dynamic> json) =>
      _$ResultPresenceFromJson(json);

  Map<String, dynamic> toJson() => _$ResultPresenceToJson(this);

  @override
  List<Object?> get props => [
    idAttendance,
    userId,
    checkIn,
    checkOut,
    attendanceDate,
    status,
    createdAt,
  ];
}
