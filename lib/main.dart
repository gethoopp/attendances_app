import 'package:attendance_app/component/routes.dart';
import 'package:attendance_app/core/amqp_conn/amqp_conn.dart';
import 'package:attendance_app/view/auth/login.dart';
import 'package:attendance_app/view/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
// );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  AmqpConn().initService;
  AmqpConn().listenMessage;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
        child: ScreenUtilInit(
          designSize: const Size(393, 852),
          minTextAdapt: true,
          builder: (context, child) {
            return MaterialApp(
              initialRoute: Routes.login,
              routes: {
                Routes.login: (context) => LoginPageScreen(),
                Routes.register: (context) => RegisterScreenPage(),
              },
              debugShowCheckedModeBanner: false,
              home: LoginPageScreen(),
            );
          },
        ));
  }
}

//this project use flutter version 3.24.0 USE PURO OR FVM
