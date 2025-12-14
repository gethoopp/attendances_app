import 'package:attendance_app/bloc/register/register_user_data/auth_user_cubit.dart';
import 'package:attendance_app/component/routes.dart';
import 'package:attendance_app/core/websocket_controller/websocket_controller.dart';
import 'package:attendance_app/extension/string_validate.dart';
import 'package:attendance_app/model/form_field/form_field.dart';

import 'package:attendance_app/model/register_form/register_form.dart';
import 'package:attendance_app/repository/users/users.dart';

import 'package:attendance_app/widget/button.dart';
import 'package:attendance_app/widget/errorText.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/register_form/cubit/register_form_cubit.dart';

class RegisterScreenPage extends StatelessWidget {
  const RegisterScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final BaseUserRepository userRepository = GetUserData();
    return RepositoryProvider.value(
      value: userRepository,
      child: MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => RegisterFormCubit(),
        ),
        BlocProvider(create: (context) => AuthUserCubit(userRepository))
      ], child: RegisterScreen()),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BaseUserRepository userRepository = GetUserData();
    return RepositoryProvider.value(
      value: userRepository,
      child: BlocProvider(
        create: (context) => AuthUserCubit(userRepository)..registerUser,
        child: _RegisterScreenContent(),
      ),
    );
  }
}

class _RegisterScreenContent extends StatefulWidget {
  @override
  State<_RegisterScreenContent> createState() => _RegisterScreenContentState();
}

class _RegisterScreenContentState extends State<_RegisterScreenContent> {
  final webSocketController = WebsocketController();
  @override
  void initState() {
    super.initState();
    webSocketController.connectSocket();
  }

  @override
  void dispose() {
    super.dispose();
    webSocketController.close();
  }

  @override
  Widget build(BuildContext context) {
    // context.read<RegisterUserCubit>().registerUser;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocBuilder<RegisterFormCubit, RegisterFormState<RegisterFormData>>(
        builder: (context, statelogin) {
          return Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.05, top: size.height * 0.06),
                  child: Text.rich(
                    TextSpan(
                        text: ' Register Account \n ',
                        style: GoogleFonts.outfit(
                            fontSize: 25, fontWeight: FontWeight.w800),
                        children: [
                          TextSpan(
                              text: 'to ',
                              style: GoogleFonts.outfit(
                                  fontSize: 25, fontWeight: FontWeight.w800)),
                          TextSpan(
                              text: 'HR Attendee',
                              style: GoogleFonts.outfit(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                  color: const Color.fromARGB(255, 7, 76, 196)))
                        ]),
                  ),
                ),
              ]),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.07,
                    ),
                    child: Text(
                      'Hello There, Register to Continue',
                      style: GoogleFonts.outfit(color: Colors.grey),
                    ),
                  )
                ],
              ),
              BlocListener<AuthUserCubit, AuthUserState>(
                listener: (context, state) {
                  if (state is AuthUserSucces) {
                    AwesomeDialog(
                            context: context,
                            title: 'Success',
                            desc: state.data,
                            dialogType: DialogType.success)
                        .show();
                  } else if (state is AuthUserErr) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.04),
                          child: Column(
                            children: [
                              buttonLogin(size,
                                  text: 'First Name',
                                  label: 'First Name',
                                  hint: 'Masukkan nama pertamamu',
                                  obs: false, onChanged: (value) {
                                context
                                    .read<RegisterFormCubit>()
                                    .onChangeUsername(statelogin.data!, value);
                                return null;
                              }),
                              ErrorTextFormField(
                                error: statelogin.data!.firstName
                                    .validateFirstName(5, 20),
                              ),
                              const SizedBox(height: 20),
                              buttonLogin(size,
                                  text: 'Last Name',
                                  label: 'Last Name',
                                  hint: 'Masukkan nama terakhirmu',
                                  obs: false, onChanged: (value) {
                                context
                                    .read<RegisterFormCubit>()
                                    .onChangeUsername(statelogin.data!, value);
                                return null;
                              }),
                              ErrorTextFormField(
                                error: statelogin.data!.lastnName
                                    .validateLastName(5, 20),
                              ),
                              const SizedBox(height: 20),
                              buttonLogin(size,
                                  text: 'Departement',
                                  obs: false,
                                  hint: 'Masukkan depatemenmu',
                                  label: 'Departement', onChanged: (value) {
                                context
                                    .read<RegisterFormCubit>()
                                    .onChangeDepartement(
                                        statelogin.data!, value);
                                return null;
                              }),
                              ErrorTextFormField(
                                error: statelogin
                                    .data!.departement.validateDepartement,
                              ),
                              const SizedBox(height: 20),
                              buttonLogin(size,
                                  text: 'Email',
                                  label: 'Email',
                                  hint: 'Masukkan email kamu',
                                  obs: false, onChanged: (value) {
                                context
                                    .read<RegisterFormCubit>()
                                    .onChangeEmail(statelogin.data!, value);
                                return null;
                              }),
                              ErrorTextFormField(
                                error: statelogin.data!.email.validateEmail,
                              ),
                              const SizedBox(height: 20),
                              buttonLogin(size,
                                  text: 'Password',
                                  label: 'Password',
                                  hint: 'Masukkan Password',
                                  obs: true, onChanged: (value) {
                                context
                                    .read<RegisterFormCubit>()
                                    .onChangePassword(statelogin.data!, value);
                                return null;
                              }),
                              ErrorTextFormField(
                                error:
                                    statelogin.data!.password.validatePassword,
                              ),
                              const SizedBox(height: 20),
                              buttonLogin(size,
                                  text: 'Rfid Number',
                                  obs: false,
                                  hint: 'Masukkan nomor RFID mu',
                                  label: 'RFID',
                                  textInput: TextInputType.number,
                                  onChanged: (value) {
                                context
                                    .read<RegisterFormCubit>()
                                    .onChangeRfid(statelogin.data!, value);
                                return null;
                              }),
                              ErrorTextFormField(
                                  error: statelogin.data!.rfid
                                      .toString()
                                      .validateRfid),
                              const SizedBox(height: 10),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: size.width * 0.08,
                                      ),
                                      child: Text(
                                        'Forgot Password ?',
                                        style: GoogleFonts.outfit(
                                            color: Colors.blue),
                                      ),
                                    ),
                                  ]),
                              const SizedBox(height: 25),
                              BlocConsumer<AuthUserCubit, AuthUserState>(
                                listener: (context, state) {
                                  if (AuthUserState is AuthUserSucces) {
                                    Navigator.pushNamed(
                                        context, Routes.dashboard);
                                  }
                                },
                                builder: (context, state) {
                                  return BlocSelector<
                                      RegisterFormCubit,
                                      RegisterFormState<RegisterFormData>,
                                      FormFieldData>(
                                    selector: (state) =>
                                        FormFieldData(validate: [
                                      statelogin.data!.firstName,
                                      statelogin.data!.lastnName,
                                      statelogin.data!.departement,
                                      statelogin.data!.email,
                                      statelogin.data!.password,
                                      statelogin.data!.rfid
                                    ], validateForm: [
                                      statelogin.data!.firstName
                                          .validateFirstName(2, 8),
                                      statelogin.data!.lastnName
                                          .validateLastName(2, 8),
                                      statelogin.data!.departement
                                          .validateDepartement,
                                      statelogin.data!.email.validateEmail,
                                      statelogin
                                          .data!.password.validatePassword,
                                      statelogin.data!.rfid
                                    ]),
                                    builder: (context, validateState) {
                                      final isLoading =
                                          state is AuthUserLoading;
                                      return buttonLoginTap(
                                        onTap: () {
                                          validateState.hasEmptyField ||
                                                  validateState.hasInvalidField
                                              ? ""
                                              : context
                                                  .read<AuthUserCubit>()
                                                  .registerUser(
                                                    context,
                                                    cardNumber:
                                                        statelogin.data!.rfid!,
                                                    firstName: statelogin
                                                        .data!.firstName!,
                                                    lastName: statelogin
                                                        .data!.lastnName!,
                                                    department: statelogin
                                                        .data!.departement!,
                                                    email:
                                                        statelogin.data!.email!,
                                                    password: statelogin
                                                        .data!.password!,
                                                  );
                                        },
                                        size,
                                        text: isLoading ? "" : "Daftar",
                                        colorbtn: validateState.hasEmptyField ||
                                                validateState.hasInvalidField ||
                                                isLoading
                                            ? Colors.grey.shade300
                                            : Colors.blue,
                                        validateState.hasEmptyField ||
                                                validateState.hasInvalidField ||
                                                isLoading
                                            ? Colors.grey.shade300
                                            : Colors.blue,
                                        textColor: validateState
                                                    .hasEmptyField &&
                                                validateState.hasInvalidField
                                            ? Colors.black
                                            : Colors.white,
                                        child: isLoading
                                            ? const SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.blue,
                                                  strokeWidth: 2,
                                                ),
                                              )
                                            : null,
                                      );
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
