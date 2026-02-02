import 'package:attendance_app/component/routes.dart';
import 'package:attendance_app/component/screen_argument.dart';
import 'package:attendance_app/view/auth/login.dart';
import 'package:attendance_app/view/auth/register.dart';
import 'package:attendance_app/widget/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    final ScreenArguments? args = settings.arguments != null
        ? settings.arguments as ScreenArguments
        : null;

    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(
          settings: RouteSettings(arguments: args, name: Routes.login),

          builder: (_) => LoginPageScreen(),
        );

      case Routes.bottomNav:
        return MaterialPageRoute(
          settings: RouteSettings(arguments: args, name: Routes.bottomNav),
          builder: (_) => BottomNavigation(),
        );

      case Routes.register:
        return MaterialPageRoute(
          settings: RouteSettings(arguments: args, name: Routes.register),
          builder: (_) => RegisterScreenPage(),
        );

      default:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.notFoundScreen),
          builder: (context) => const Center(child: Text("Not Found Routes")),
        );
    }
  }
}
