import 'package:attendance_app/bloc/register/cubit/register_user_cubit.dart';
import 'package:attendance_app/controller/repository/users/users.dart';
import 'package:attendance_app/extension/string_validate.dart';
import 'package:attendance_app/view/homepage/dashborad_screen.dart';
import 'package:attendance_app/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BaseUserRepository userRepository = GetUserData();
    return RepositoryProvider.value(
      value: userRepository,
      child: BlocProvider(
        create: (context) => RegisterUserCubit(userRepository)..registerUser,
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
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController emailContoller = TextEditingController();
  TextEditingController passContoller = TextEditingController();
  TextEditingController passConfirmContoller = TextEditingController();
  TextEditingController rfidNumber = TextEditingController();
  TextEditingController departementController = TextEditingController();

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    emailContoller.dispose();
    passContoller.dispose();
    passConfirmContoller.dispose();
    rfidNumber.dispose();
    departementController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<RegisterUserCubit>().registerUser;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
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
          BlocListener<RegisterUserCubit, RegisterUserState>(
            listener: (context, state) {
              if (state is RegisterUserSucces) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboradScreen(),
                  ),
                );
              } else if (state is RegisterUserErr) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );

                debugPrint("Error: ${state.message}");
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
                              obs: false,
                              controll: firstName,
                              validator: (text) =>
                                  text.validateFirstName(5, 20),
                              onChanged: (value) {
                                setState(() {
                                  firstName.text = value;
                                });
                                return value;
                              }),
                          const SizedBox(height: 20),
                          buttonLogin(size,
                              text: 'Last Name',
                              obs: false,
                              controll: lastName,
                              validator: (text) => text.validateLastName(5, 20),
                              onChanged: (value) {
                                setState(() {
                                  lastName.text = value;
                                });
                                return value;
                              }),
                          const SizedBox(height: 20),
                          buttonLogin(size,
                              text: 'Departement',
                              obs: false,
                              controll: departementController,
                              validator: (text) => text.validateLastName(5, 20),
                              onChanged: (value) {
                                setState(() {
                                  departementController.text = value;
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
                              text: 'Rfid Number',
                              obs: false,
                              textInput: TextInputType.number,
                              controll: rfidNumber,
                              validator: (text) => text.validateRfid,
                              onChanged: (value) {
                                setState(() {
                                  rfidNumber.text = value;
                                });
                                return value;
                              }),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: size.width * 0.08,
                                  ),
                                  child: Text(
                                    'Forgot Password ?',
                                    style:
                                        GoogleFonts.outfit(color: Colors.blue),
                                  ),
                                ),
                              ]),
                          const SizedBox(height: 25),
                          buttonLoginTap(onTap: () {
                            context.read<RegisterUserCubit>().registerUser(
                                  cardNumber: int.parse(rfidNumber.text),
                                  firstName: firstName.text,
                                  lastName: lastName.text,
                                  department: departementController.text,
                                  email: emailContoller.text,
                                  password: passContoller.text,
                                );

                            debugPrint("Berhasil ditekan");
                          },
                              size,
                              text: 'Register',
                              colorbtn: Colors.blue,
                              Colors.blue,
                              textColor: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
