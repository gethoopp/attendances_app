import 'package:attendance_app/bloc/login_form/login_form_cubit.dart';
import 'package:attendance_app/bloc/register/register_user_data/auth_user_cubit.dart';
import 'package:attendance_app/component/screen_argument.dart';
import 'package:attendance_app/component/widget_mixin.dart';
import 'package:attendance_app/extension/string_validate.dart';
import 'package:attendance_app/model/form_field/form_field.dart';
import 'package:attendance_app/model/login_form/login_form.dart';
import 'package:attendance_app/repository/users/base_user.dart';
import 'package:attendance_app/widget/button.dart';
import 'package:attendance_app/widget/error_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../component/routes.dart';

class LoginPageScreen extends StatelessWidget {
  const LoginPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginFormCubit()),
        BlocProvider(
          create: (context) =>
              AuthUserCubit(context.read<BaseUserRepository>()),
        ),
      ],
      child: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> with WidgetMixin {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<LoginFormCubit, LoginFormState<LoginFormData>>(
        builder: (context, stateData) {
          if (stateData.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                // Row(
                //   children: [
                //     Padding(
                //       padding: EdgeInsets.only(
                //         left: size.width * 0.07,
                //       ),
                //       child: Image(image: AssetImage(Assets.logo)),
                //     )
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.05,
                        top: size.height * 0.1,
                      ),
                      child: Text.rich(
                        TextSpan(
                          text: ' Welcome Back (logo) \n ',
                          style: GoogleFonts.outfit(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          ),
                          children: [
                            TextSpan(
                              text: 'to ',
                              style: GoogleFonts.outfit(
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            TextSpan(
                              text: 'HR Attendee',
                              style: GoogleFonts.outfit(
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                                color: const Color.fromARGB(255, 7, 76, 196),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.07),
                      child: Text(
                        'Hello There, Login to Continue',
                        style: GoogleFonts.outfit(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.05),
                  child: Column(
                    children: [
                      buttonLogin(
                        size,
                        text: 'Email',
                        label: 'Email',
                        hint: 'Massukan email kamu',
                        obs: false,
                        onChanged: (value) {
                          context.read<LoginFormCubit>().onChangeUsername(
                            stateData.data!,
                            value,
                          );
                        },
                      ),
                      ErrorTextFormField(
                        error: stateData.data!.email.validateEmail,
                      ),
                      const SizedBox(height: 20),
                      buttonLogin(
                        size,
                        text: 'Password',
                        label: 'Password',
                        hint: 'Masukkan password kamu',
                        obs: true,
                        onChanged: (value) {
                          context.read<LoginFormCubit>().onChangePassword(
                            stateData.data!,
                            value,
                          );
                        },
                      ),
                      ErrorTextFormField(
                        error: stateData.data!.password.validatePassword,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: size.width * 0.08),
                      child: Text(
                        'Forgot Password ?',
                        style: GoogleFonts.outfit(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                BlocConsumer<AuthUserCubit, AuthUserState>(
                  listener: (context, state) {
                    if (state is RegisterAuthSucces) {
                      Navigator.pushNamed(
                        context,
                        Routes.home,
                        arguments: ScreenArguments(
                          state.data.result!.idUsers!,
                          state.data.token!,
                        ),
                      );
                    }

                    if (state is AuthUserErr) {
                      showMyDialog(state.message);
                    }
                  },
                  builder: (context, state) {
                    return BlocSelector<
                      LoginFormCubit,
                      LoginFormState<LoginFormData>,
                      FormFieldData
                    >(
                      selector: (statedata) => FormFieldData(
                        validate: [
                          statedata.data!.email,
                          statedata.data!.password,
                        ],
                        validateForm: [
                          statedata.data!.email.validateEmail,
                          statedata.data!.password.validatePassword,
                        ],
                      ),
                      builder: (context, validateState) {
                        final isLoading = state is RegisterAuthLoading;
                        debugPrint("ini state $isLoading ");
                        return buttonLoginTap(
                          onTap: () {
                            if (validateState.hasEmptyField ||
                                validateState.hasInvalidField ||
                                isLoading) {
                              return;
                            }

                            context.read<AuthUserCubit>().loginUser(
                              email: stateData.data!.email!,
                              pass: stateData.data!.password!,
                            );
                          },
                          size,
                          text: isLoading ? "" : "Login",
                          colorbtn:
                              validateState.hasEmptyField ||
                                  validateState.hasInvalidField ||
                                  isLoading
                              ? Colors.grey.shade300
                              : Colors.blue,
                          validateState.hasEmptyField ||
                                  validateState.hasInvalidField ||
                                  isLoading
                              ? Colors.grey.shade300
                              : Colors.blue,
                          textColor:
                              validateState.hasEmptyField ||
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
                ),
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
                    textColor: Colors.black,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.02),
                  child: buttonLoginTap(
                    size,
                    text: 'Apple ID',
                    colorbtn: Colors.transparent,
                    null,
                    textColor: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Didn't have account?"),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.register);
                        },
                        child: Text(
                          'Register',
                          style: GoogleFonts.outfit(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
