import '../basemodels.dart';

class LoginFormData extends BaseModel {
  final String? email;
  final String? password;
  final bool securePassword;

  LoginFormData({this.email, this.password, this.securePassword = true});

  @override
  copyWith({String? username, String? password, bool? securePassword}) {
    return LoginFormData(
      email: username ?? email,
      password: password ?? this.password,
      securePassword: securePassword ?? this.securePassword,
    );
  }

  @override
  List<Object?> get props => [email, password, securePassword];
}
