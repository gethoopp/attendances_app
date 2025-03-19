import 'package:attendance_app/component/routes.dart';
import 'package:attendance_app/core/image_picker/amqp_conn.dart';
import 'package:attendance_app/view/auth/login.dart';
import 'package:attendance_app/view/auth/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  AmqpConn().initService;
  AmqpConn().listenMessage;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
      child: MaterialApp(
        initialRoute: Routes.login,
        routes: {
          Routes.login: (context) => LoginPage(),
          Routes.register: (context) => RegisterScreen(),
        },
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}

//this project use flutter version 3.24.0 USE PURO OR FVM