// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  message: json['message'] as String?,
  result: json['result'] == null
      ? null
      : Result.fromJson(json['result'] as Map<String, dynamic>),
  status: (json['status'] as num?)?.toInt(),
  token: json['token'] as String?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'message': instance.message,
  'result': instance.result,
  'status': instance.status,
  'token': instance.token,
};

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
  idUsers: (json['id_users'] as num?)?.toInt(),
  rfidId: (json['rfid_id'] as num?)?.toInt(),
  idFirstName: json['id_first_name'] as String?,
  idLastName: json['id_last_name'] as String?,
  idDepartement: json['id_departement'] as String?,
  emailUser: json['email_user'] as String?,
);

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
  'id_users': instance.idUsers,
  'rfid_id': instance.rfidId,
  'id_first_name': instance.idFirstName,
  'id_last_name': instance.idLastName,
  'id_departement': instance.idDepartement,
  'email_user': instance.emailUser,
};
