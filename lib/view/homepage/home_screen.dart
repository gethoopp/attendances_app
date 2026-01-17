import 'package:attendance_app/bloc/base/base_state.dart';
import 'package:attendance_app/bloc/cubit/user_presence_cubit.dart';
import 'package:attendance_app/bloc/presence/presence_cubit.dart';
import 'package:attendance_app/bloc/register/register_user_data/auth_user_cubit.dart';
import 'package:attendance_app/component/assets.dart';
import 'package:attendance_app/component/screen_argument.dart';
import 'package:attendance_app/component/widget_mixin.dart';
import 'package:attendance_app/model/presence_data/presence_data.dart';
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
        ),

        BlocProvider(
          create: (context) =>
              UserPresenceCubit(context.read<BasePresence>())
                ..getUserPresence(args.token, args.Id),
        ),
      ],
      child: HomeScreenPage(token: args.token),
    );
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
                  SizedBox(height: 50.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 35.w),
                        child: CircleAvatar(radius: 25.r),
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
                      ),
                    ],
                  ),
                  SizedBox(height: 50.h),
                  showCalendar(
                    selectedDate: _selectedDate,
                    onDateChange: (p0) {
                      setState(() {
                        _selectedDate = p0;
                        context.read<UserPresenceCubit>().getUserByDate(
                          widget.token,
                          stateData.data.result!.idUsers!,
                          _selectedDate,
                        );
                      });
                    },
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: Text("Today Attendance"),
                      ),
                    ],
                  ),
                  BlocBuilder<UserPresenceCubit, DataState<DataPresence>>(
                    builder: (context, state) {
                      debugPrint("State sekarang $state");
                      final presence = state.data;
                      return GridView.count(
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
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.r),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        width: 35.w,
                                        height: 35.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),

                                          color: Colors.lightBlue.shade50,
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            Assets.iconCheckin,
                                            width: 20.w,
                                            height: 20.h,
                                          ),
                                        ),
                                      ),
                                    ),

                                    Text("Check-In"),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: Text(
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    presence?.result.checkIn != null
                                        ? "${presence!.result.checkIn.hour}:${presence.result.checkIn.minute} am"
                                        : "N/A",
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: Text(
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    presence?.result.checkIn != null
                                        ? "On Time"
                                        : "N/A",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.r),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        width: 35.w,
                                        height: 35.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),

                                          color: Colors.lightBlue.shade50,
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            Assets.iconCheckin,
                                            width: 20.w,
                                            height: 20.h,
                                          ),
                                        ),
                                      ),
                                    ),

                                    Text("Check-Out"),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: Text(
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    presence?.result.checkOut != null
                                        ? "${presence?.result.checkOut!.hour}:${presence?.result.checkOut!.minute} pm"
                                        : "N/A",
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: Text(
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    presence?.result.checkOut != null
                                        ? "Go Home"
                                        : "N/A",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.r),
                              ),
                            ),
                            child: Text(presence?.result.status ?? "N/A"),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.r),
                              ),
                            ),
                            child: Text(presence?.result.status ?? "N/A"),
                          ),
                        ],
                      );
                    },
                  ),

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
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                        ),
                      ),
                    ],
                  ),
                  BlocConsumer<PresenceCubit, DataState>(
                    listener: (context, state) {
                      if (state is DataSucces) {
                        context.read<UserPresenceCubit>().getUserPresence(
                          widget.token,
                          stateData.data.result!.idUsers!,
                        );
                      }

                      if (state is DataError) {
                        showMyDialog(state.message!);
                      }
                    },
                    builder: (context, state) {
                      return BlocBuilder<
                        UserPresenceCubit,
                        DataState<DataPresence>
                      >(
                        builder: (context, state) {
                          final presence = state.data;
                          return Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: SlideAction(
                              borderRadius: 10.r,
                              height: 60.h,
                              sliderButtonIconSize: 15,
                              outerColor: presence?.result.status == "IN"
                                  ? Colors.redAccent
                                  : Colors.blueAccent,
                              text: presence?.result.status == "IN"
                                  ? "Swipe to check out"
                                  : "Swipe to check in",
                              textStyle: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.white,
                              ),
                              onSubmit: () async {
                                presence?.result.status == "IN"
                                    ? context
                                          .read<PresenceCubit>()
                                          .sendCheckOut(
                                            widget.token,
                                            stateData.data.result!.idUsers!,
                                          )
                                    : presence?.result.status == "OUT"
                                    ? null
                                    : context.read<PresenceCubit>().sendCheckIn(
                                        widget.token,
                                        stateData.data.result!.idUsers!,
                                      );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
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
