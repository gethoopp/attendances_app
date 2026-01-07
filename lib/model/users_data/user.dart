import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  const User({
    required this.message,
    required this.result,
    required this.status,
    required this.token,
  });

  final String? message;
  final Result? result;
  final int? status;
  final String? token;

  User copyWith({
    String? message,
    Result? result,
    int? status,
    String? token,
  }) {
    return User(
      message: message ?? this.message,
      result: result ?? this.result,
      status: status ?? this.status,
      token: token ?? this.token,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
        message,
        result,
        status,
        token,
      ];
}

@JsonSerializable()
class Result extends Equatable {
  const Result({
    required this.idUsers,
    required this.rfidId,
    required this.idFirstName,
    required this.idLastName,
    required this.idDepartement,
    required this.emailUser,
  });

  final int? idUsers;
  final int? rfidId;
  final String? idFirstName;
  final String? idLastName;
  final String? idDepartement;
  final String? emailUser;

  Result copyWith({
    int? idUsers,
    int? rfidId,
    String? idFirstName,
    String? idLastName,
    String? idDepartement,
    String? emailUser,
  }) {
    return Result(
      idUsers: idUsers ?? this.idUsers,
      rfidId: rfidId ?? this.rfidId,
      idFirstName: idFirstName ?? this.idFirstName,
      idLastName: idLastName ?? this.idLastName,
      idDepartement: idDepartement ?? this.idDepartement,
      emailUser: emailUser ?? this.emailUser,
    );
  }

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  List<Object?> get props => [
        idUsers,
        rfidId,
        idFirstName,
        idLastName,
        idDepartement,
        emailUser,
      ];
}
