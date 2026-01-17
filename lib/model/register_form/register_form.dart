import '../basemodels.dart';

class RegisterFormData extends BaseModel {
  final String? firstName;
  final String? lastnName;
  final String? departement;
  final String? email;
  final String? password;
  final int? rfid;

  RegisterFormData({
    this.firstName,
    this.lastnName,
    this.departement,
    this.email,
    this.password,
    this.rfid,
  });

  @override
  copyWith({
    String? firstName,
    String? lastName,
    String? departement,
    String? email,
    String? password,
    int? rfid,
  }) {
    return RegisterFormData(
      firstName: firstName ?? this.firstName,
      lastnName: lastName ?? lastnName,
      departement: departement ?? this.departement,
      email: email ?? this.email,
      password: password ?? this.password,
      rfid: rfid ?? this.rfid,
    );
  }

  @override
  List<Object?> get props => [
    firstName,
    lastnName,
    departement,
    email,
    password,
    rfid,
  ];
}
