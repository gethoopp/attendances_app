import 'package:attendance_app/bloc/them_data/theme_data_cubit.dart';
import 'package:attendance_app/component/routes.dart';
import 'package:attendance_app/core/amqp_conn/amqp_conn.dart';
import 'package:attendance_app/extension/app_router.dart';
import 'package:attendance_app/repository/locate_user/locate_repo.dart';
import 'package:attendance_app/repository/presence/presence.dart';
import 'package:attendance_app/repository/total_worker/total_worker.dart';
import 'package:attendance_app/repository/users/base_user.dart';
import 'package:attendance_app/repository/users/user.dart';
import 'package:attendance_app/view/auth/login.dart';
import 'package:attendance_app/view/auth/register.dart';
import 'package:attendance_app/view/Home/dashboard/home_screen.dart';
import 'package:attendance_app/widget/bottom_navigation.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/foundation.dart';
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
  final BasetotalDataworker basetotalDataworker = BaseTotalWorker();
  LocateUser().getPermisionLocation();

  runApp(
    MyApp(
      userRepository: userRepository,
      basePresence: basePresence,
      basetotalDataworker: basetotalDataworker,
    ),
  );
}

class MyApp extends StatelessWidget {
  final BaseUserRepository userRepository;
  final BasePresence basePresence;
  final BasetotalDataworker basetotalDataworker;
  const MyApp({
    super.key,
    required this.userRepository,
    required this.basePresence,
    required this.basetotalDataworker,
  });

  @override
  Widget build(BuildContext context) {
    final _appRouter = AppRouter();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<BaseUserRepository>.value(value: userRepository),
        RepositoryProvider<BasePresence>.value(value: basePresence),
        RepositoryProvider<BasetotalDataworker>.value(
          value: basetotalDataworker,
        ),
      ],
      child: BlocProvider(
        create: (context) => ThemeDataCubit(),
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
              return BlocBuilder<ThemeDataCubit, ThemeDataState>(
                builder: (context, state) {
                  if (kDebugMode) {
                    debugPrint("ini adalah state main ${state.themeData}");
                  }
                  return MaterialApp(
                    theme: state.themeData,
                    navigatorKey: navigatorKey,
                    navigatorObservers: [ChuckerFlutter.navigatorObserver],
                    initialRoute: Routes.login,
                    // routes: {
                    //   Routes.login: (context) => LoginPageScreen(),
                    //   Routes.register: (context) => RegisterScreenPage(),
                    //   Routes.home: (context) => HomeScreen(),
                    //   Routes.bottomNav: (context) => BottomNavigation(),
                    // },
                    debugShowCheckedModeBanner: false,
                    onGenerateRoute: _appRouter.onGenerateRoute,
                    home: LoginPageScreen(),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

//this project use flutter version 3.24.0 USE PURO OR FVM
