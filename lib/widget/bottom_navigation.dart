import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:attendance_app/bloc/them_data/theme_data_cubit.dart';
import 'package:attendance_app/component/assets.dart';
import 'package:attendance_app/component/screen_argument.dart';
import 'package:attendance_app/view/Home/dashboard/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int activeIndex = 0;
  late ScreenArguments args;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
  }

  final List<String> iconListLight = [
    Assets.iconHome,
    Assets.iconCalendar,
    Assets.iconChair,
    Assets.iconUser,
  ];

  final List<String> iconListDark = [
    Assets.iconHome,
    Assets.iconCalendar,
    Assets.iconChair,
    Assets.iconUser,
  ];

  /// ✅ Pages used by bottom navigation
  late final List<Widget> pageList = [
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeDataCubit, ThemeDataState>(
      builder: (context, state) {
        final data = state.themeData;
        return Scaffold(
          body: IndexedStack(index: activeIndex, children: pageList),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // FAB action here
            },
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar.builder(
            backgroundColor: Theme.of(context).colorScheme.surface,
            itemCount: data.brightness == Brightness.light
                ? iconListLight.length
                : iconListDark.length,
            activeIndex: activeIndex,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.softEdge,
            tabBuilder: (int index, bool isActive) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  data.brightness == Brightness.light
                      ? Image.asset(
                          iconListDark[index],
                          width: 20.w,
                          height: 20.h,
                          color: Theme.of(context).canvasColor,
                        )
                      : Image.asset(
                          iconListLight[index],
                          width: 20.w,
                          height: 20.h,
                          color: Theme.of(context).canvasColor,
                        ),

                  const SizedBox(height: 4),
                ],
              );
            },
            onTap: (index) {
              setState(() {
                activeIndex = index;
              });
            },
          ),
        );
      },
    );
  }
}
