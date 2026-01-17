import 'package:attendance_app/component/routes.dart';
import 'package:attendance_app/core/amqp_conn/amqp_conn.dart';
import 'package:attendance_app/repository/presence/presence.dart';
import 'package:attendance_app/repository/users/base_user.dart';
import 'package:attendance_app/repository/users/user.dart';
import 'package:attendance_app/view/auth/login.dart';
import 'package:attendance_app/view/auth/register.dart';
import 'package:attendance_app/view/homepage/home_screen.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp();
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  // );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final amqPcon = AmqpConn();
  amqPcon.initService;
  // amqPcon.listenMessage(onmessage)
  final BaseUserRepository userRepository = GetUserData();
  final BasePresence basePresence = CheckInRepository();

  runApp(MyApp(userRepository: userRepository, basePresence: basePresence));
}

class MyApp extends StatelessWidget {
  final BaseUserRepository userRepository;
  final BasePresence basePresence;
  const MyApp({
    super.key,
    required this.userRepository,
    required this.basePresence,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<BaseUserRepository>.value(value: userRepository),
        RepositoryProvider<BasePresence>.value(value: basePresence),
      ],
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: ScreenUtilInit(
          designSize: const Size(393, 852),
          minTextAdapt: true,
          builder: (context, child) {
            return MaterialApp(
              navigatorObservers: [ChuckerFlutter.navigatorObserver],
              initialRoute: Routes.login,
              routes: {
                Routes.login: (context) => LoginPageScreen(),
                Routes.register: (context) => RegisterScreenPage(),
                Routes.home: (context) => HomeScreen(),
              },
              debugShowCheckedModeBanner: false,
              home: LoginPageScreen(),
            );
          },
        ),
      ),
    );
  }
}

//this project use flutter version 3.24.0 USE PURO OR FVM
