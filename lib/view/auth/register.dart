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
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
      ),
    );
  }
}
