import 'package:attendance_app/bloc/base/base_state.dart';
import 'package:attendance_app/bloc/presence/presence_cubit.dart';
import 'package:attendance_app/bloc/register/register_user_data/auth_user_cubit.dart';
import 'package:attendance_app/component/assets.dart';
import 'package:attendance_app/component/screen_argument.dart';
import 'package:attendance_app/component/widget_mixin.dart';
import 'package:attendance_app/repository/presence/base_presence.dart';
import 'package:attendance_app/repository/users/base_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slide_to_act/slide_to_act.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthUserCubit(context.read<BaseUserRepository>())
                  ..getUser(args.Id, args.token),
          ),
          BlocProvider(
            create: (context) => PresenceCubit(context.read<BasePresence>()),
          )
        ],
        child: HomeScreenPage(
          token: args.token,
        ));
  }
}

class HomeScreenPage extends StatefulWidget {
  final String token;
  const HomeScreenPage({super.key, required this.token});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> with WidgetMixin {
  var _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthUserCubit, AuthUserState>(
      builder: (context, stateData) {
        if (stateData is RegisterAuthSucces) {
          final data = stateData.data;
          return Scaffold(
            backgroundColor: Colors.grey.shade200,
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 35.w),
                        child: CircleAvatar(
                          radius: 25.r,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: Column(
                          children: [
                            Text(data.result!.idFirstName!),
                            Text(data.result!.idDepartement!),
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 40.w),
                        child: Image.asset(
                          Assets.notif,
                          width: 25.w,
                          height: 20.h,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  showCalendar(
                    selectedDate: _selectedDate,
                    onDateChange: (p0) {
                      setState(() {
                        _selectedDate = p0;
                      });
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: Text("Today Attendance"),
                      ),
                    ],
                  ),
                  GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12.h,
                    crossAxisSpacing: 20.w,
                    childAspectRatio: 1.5,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r))),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r))),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r))),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r))),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: Text("Your Activity"),
                      ),
                      Spacer(),
                      Padding(
                          padding: EdgeInsetsGeometry.only(right: 20.h),
                          child: Text("View All")),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  GridView.count(
                    mainAxisSpacing: 16.h,
                    crossAxisCount: 1,
                    childAspectRatio: 3.5,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r))),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r))),
                      ),
                    ],
                  ),
                  BlocConsumer<PresenceCubit, DataState>(
                    listener: (context, state) {
                      if (state is DataSucces) {
                        showMyDialog(state.message!);
                      }
                    },
                    builder: (context, state) {
                      final isSucces = state is DataSucces;
                      return Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: SlideAction(
                          borderRadius: 10.r,
                          height: 60.h,
                          sliderButtonIconSize: 15,
                          outerColor:
                              isSucces ? Colors.blueAccent : Colors.redAccent,
                          text: isSucces
                              ? "Swipe to check in"
                              : "Swipe to check out",
                          textStyle:
                              TextStyle(fontSize: 15.sp, color: Colors.white),
                          onSubmit: () {
                            context.read<PresenceCubit>().sendCheckIn(
                                widget.token, stateData.data.result!.idUsers!);
                            return null;
                          },
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        }

        if (stateData is AuthUserErr) {
          return Center();
        }

        if (stateData is RegisterAuthLoading) {}

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
