<<<<<<< HEAD
import 'package:attendance_app/component/assets.dart';
import 'package:attendance_app/extension/string_validate.dart';
import 'package:attendance_app/view/homepage/dashborad_screen.dart';
import 'package:attendance_app/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailContoller = TextEditingController();
  TextEditingController passContoller = TextEditingController();
  TextEditingController passConfirmContoller = TextEditingController();
=======
import 'package:attendance_app/bloc/register/register_user_data/auth_user_cubit.dart';
import 'package:attendance_app/component/routes.dart';
import 'package:attendance_app/component/widget_mixin.dart';
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
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) =>
              AuthUserCubit(context.read<BaseUserRepository>())),
      BlocProvider(
        create: (context) => RegisterFormCubit(),
      ),
    ], child: _RegisterScreenContent());
  }
}

class _RegisterScreenContent extends StatefulWidget {
  @override
  State<_RegisterScreenContent> createState() => _RegisterScreenContentState();
}

class _RegisterScreenContentState extends State<_RegisterScreenContent>
    with WidgetMixin {
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

>>>>>>> master
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
<<<<<<< HEAD
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(top: size.height * 0.1),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.07,
                  ),
                  child: Image(image: AssetImage(Assets.logo,),width: 200,height: 200,),
                )
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(
                    left: size.width * 0.05, top: size.height * 0.02),
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
            Expanded(
              child: SingleChildScrollView(
                
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.05),
                      child: Column(
                        children: [
                          buttonLogin(size,
                              text: 'First Name',
                              obs: false,
                              controll: emailContoller,
                              validator: (text) => text.validateEmail,
                              onChanged: (value) {
                                setState(() {
                                  emailContoller.text = value;
                                });
                                return value;
                              }),
                          const SizedBox(height: 20),
                          buttonLogin(size,
                              text: 'Last Name',
                              obs: false,
                              controll: emailContoller,
                              validator: (text) => text.validateEmail,
                              onChanged: (value) {
                                setState(() {
                                  emailContoller.text = value;
                                });
                                return value;
                              }),
                          const SizedBox(height: 20),
                          buttonLogin(size,
                              text: 'Email',
                              obs: false,
                              controll: emailContoller,
                              validator: (text) => text.validateEmail,
                              onChanged: (value) {
                                setState(() {
                                  emailContoller.text = value;
                                });
                                return value;
                              }),
                          const SizedBox(height: 20),
                          buttonLogin(size,
                              text: 'Password',
                              obs: true,
                              controll: passContoller,
                              validator: (text) => text.validatePassword,
                              onChanged: (value) {
                                setState(() {
                                  passContoller.text = value;
                                });
                                return value;
                              }),

                                 const SizedBox(height: 20),
                          buttonLogin(size,
                              text: 'Confirm Password',
                              obs: true,
                              controll: passConfirmContoller,
                              validator: (text) => text.validateConfirmPassword,
                              onChanged: (value) {
                                setState(() {
                                  passConfirmContoller.text = value;
                                });
                                return value;
                              }),
                          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: size.width * 0.08,
                              ),
                              child: Text(
                                'Forgot Password ?',
                                style: GoogleFonts.outfit(color: Colors.blue),
                              ),
                            ),
                          ]),
                          const SizedBox(height: 25),
                          buttonLoginTap(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DashboradScreen())),
                              size,
                              text: 'Login',
                              colorbtn: Colors.blue,
                              Colors.blue,
                              textColor: Colors.white),
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.02),
                            child: Text(
                              'Or continue with social account',
                              style: GoogleFonts.outfit(color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.03),
                            child: buttonLoginTap(
                                size,
                                text: 'Google',
                                colorbtn: Colors.transparent,
                                null,
                                textColor: Colors.black),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Didn't have account?"),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Register',
                                  style: GoogleFonts.outfit(color: Colors.blue),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
=======
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
              Expanded(
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
                                  .onChangeFirstName(statelogin.data!, value);
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
                                  .onChangeLastName(statelogin.data!, value);
                            }),
                            ErrorTextFormField(
                              error: statelogin.data!.lastnName
                                  .validateLastName(5, 20),
                            ),
                            const SizedBox(height: 20),
                            buttonLogin(size,
                                text: 'Departement',
                                obs: false,
                                hint: 'Masukkan departemenmu',
                                label: 'Departement', onChanged: (value) {
                              context
                                  .read<RegisterFormCubit>()
                                  .onChangeDepartement(statelogin.data!, value);
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
                            }),
                            ErrorTextFormField(
                              error: statelogin.data!.password.validatePassword,
                            ),
                            // StreamBuilder<Map<String, dynamic>>(
                            //     stream: webSocketController.stream,
                            //     builder: (context, data) {
                            //       String rfidValue = data.hasData
                            //           ? data.data!['rfid_tag'].toString()
                            //           : '';

                            //       return buttonInputRfid(
                            //         size,
                            //         text: 'Rfid Number',
                            //         obs: false,
                            //         hint: 'Masukkan nomor RFID mu',
                            //         label: 'RFID',
                            //         textInput: TextInputType.number,
                            //         initialValue: rfidValue,
                            //       );
                            //     }),
                            const SizedBox(height: 20),
                            buttonInputRfid(
                              size,
                              text: "Rfid Number",
                              obs: false,
                              label: "Rfid",
                              hint: "Masukkan nomor Rfid mu",
                              onChanged: (value) {
                                context.read<RegisterFormCubit>().onChangeRfid(
                                    statelogin.data!, int.parse(value));
                              },
                            ),
                            ErrorTextFormField(
                              error:
                                  statelogin.data!.rfid.toString().validateRfid,
                            ),

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
                            const SizedBox(height: 15),
                            BlocConsumer<AuthUserCubit, AuthUserState>(
                              listener: (context, state) {
                                if (state is AuthUserSucces) {
                                  Navigator.pushNamed(context, Routes.login);
                                }

                                if (state is AuthUserErr) {
                                  showMyDialog(state.message);
                                }
                              },
                              builder: (context, state) {
                                return BlocSelector<
                                    RegisterFormCubit,
                                    RegisterFormState<RegisterFormData>,
                                    FormFieldData>(
                                  selector: (statedata) =>
                                      FormFieldData(validate: [
                                    statedata.data!.firstName,
                                    statedata.data!.lastnName,
                                    statedata.data!.departement,
                                    statedata.data!.email,
                                    statedata.data!.password,
                                  ], validateForm: [
                                    statedata.data!.firstName
                                        .validateFirstName(5, 20),
                                    statedata.data!.lastnName
                                        .validateLastName(5, 20),
                                    statedata
                                        .data!.departement.validateDepartement,
                                    statedata.data!.email.validateEmail,
                                    statedata.data!.password.validatePassword,
                                  ]),
                                  builder: (context, validateState) {
                                    final isLoading = state is AuthUserLoading;
                                    debugPrint("ini state $isLoading ");
                                    return buttonLoginTap(
                                      onTap: () {
                                        if (validateState.hasEmptyField ||
                                            validateState.hasInvalidField ||
                                            isLoading) {
                                          return;
                                        }

                                        context
                                            .read<AuthUserCubit>()
                                            .registerUser(
                                              rfid: statelogin.data!.rfid!,
                                              firstName:
                                                  statelogin.data!.firstName!,
                                              lastName:
                                                  statelogin.data!.lastnName!,
                                              department:
                                                  statelogin.data!.departement!,
                                              email: statelogin.data!.email!,
                                              password:
                                                  statelogin.data!.password!,
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
                                      textColor: validateState.hasEmptyField ||
                                              validateState.hasInvalidField ||
                                              isLoading
                                          ? Colors.black
                                          : Colors.white,
                                      child: isLoading
                                          ? const SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
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
            ],
          );
        },
>>>>>>> master
      ),
    );
  }
}
