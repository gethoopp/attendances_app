import '../basemodels.dart';

class RegisterFormData extends BaseModel {
  final int? rfid;
  final String? firstName;
  final String? lastnName;
  final String? departement;

  final String? email;
  final String? password;
  final bool securePassword;

  RegisterFormData(
      {this.rfid,
      this.firstName,
      this.lastnName,
      this.departement,
      this.email,
      this.password,
      this.securePassword = true});

  @override
  copyWith(
      {int? rfid,
      String? firstName,
      String? lastName,
      String? departement,
      String? email,
      String? password,
      bool? securePassword}) {
    return RegisterFormData(
      rfid: rfid ?? rfid,
      firstName: firstName ?? firstName,
      lastnName: lastName ?? lastName,
      departement: departement ?? departement,
      email: email ?? email,
      password: password ?? this.password,
      securePassword: securePassword ?? this.securePassword,
    );
  }

  @override
  List<Object?> get props => [
        rfid,
        firstName,
        lastnName,
        departement,
        email,
        password,
        securePassword
      ];
}
