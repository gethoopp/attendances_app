// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presence_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataPresence _$DataPresenceFromJson(Map<String, dynamic> json) => DataPresence(
  message: json['message'] as String,
  result: ResultPresence.fromJson(json['result'] as Map<String, dynamic>),
  status: (json['status'] as num).toInt(),
);

Map<String, dynamic> _$DataPresenceToJson(DataPresence instance) =>
    <String, dynamic>{
      'message': instance.message,
      'result': instance.result,
      'status': instance.status,
    };

ResultPresence _$ResultPresenceFromJson(Map<String, dynamic> json) =>
    ResultPresence(
      idAttendance: (json['id_attendance'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      checkIn: DateTime.parse(json['check_in'] as String),
      checkOut: json['check_out'] == null
          ? null
          : DateTime.parse(json['check_out'] as String),
      attendanceDate: DateTime.parse(json['attendance_date'] as String),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$ResultPresenceToJson(ResultPresence instance) =>
    <String, dynamic>{
      'id_attendance': instance.idAttendance,
      'user_id': instance.userId,
      'check_in': instance.checkIn.toIso8601String(),
      'check_out': instance.checkOut?.toIso8601String(),
      'attendance_date': instance.attendanceDate.toIso8601String(),
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
    };
