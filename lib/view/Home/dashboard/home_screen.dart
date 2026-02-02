import 'package:attendance_app/bloc/base/base_state.dart';
import 'package:attendance_app/bloc/them_data/theme_data_cubit.dart';
import 'package:attendance_app/bloc/total_worker/cubit/total_worker_dart_cubit.dart';
import 'package:attendance_app/bloc/user_presence/user_presence_cubit.dart';
import 'package:attendance_app/bloc/presence/presence_cubit.dart';
import 'package:attendance_app/bloc/register/register_user_data/auth_user_cubit.dart';
import 'package:attendance_app/component/assets.dart';
import 'package:attendance_app/component/screen_argument.dart';
import 'package:attendance_app/component/widget_mixin.dart';
import 'package:attendance_app/core/convert_date/convert_date.dart';
import 'package:attendance_app/model/Total_data_worker/total_data_worker.dart';
import 'package:attendance_app/model/presence_data/presence_data.dart';
import 'package:attendance_app/repository/presence/presence.dart';
import 'package:attendance_app/repository/total_worker/base_total_worker.dart';
import 'package:attendance_app/repository/users/users.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:slide_to_act/slide_to_act.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScreenArguments args;
  late String result;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final selectDate = DateTime.now().toUtc();
    result = ConvertDate().convertDate(selectDate).toString();
    args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
  }

  @override
  Widget build(BuildContext context) {
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
                ..getUserPresence(args.token, args.Id, result),
        ),

        BlocProvider(
          create: (context) =>
              TotalWorkerDartCubit(context.read<BasetotalDataworker>()),
        ),
      ],
      child: HomeScreenPage(token: args.token, result: result),
    );
  }
}

class HomeScreenPage extends StatefulWidget {
  final String token;
  final String result;
  const HomeScreenPage({super.key, required this.token, required this.result});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> with WidgetMixin {
  var _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthUserCubit, AuthUserState>(
      builder: (context, stateData) {
        if (kDebugMode) {
          debugPrint("Result tanggal ${widget.result}");
        }
        if (stateData is RegisterAuthSucces) {
          final data = stateData.data;
          return Scaffold(
            body: RefreshIndicator(
              onRefresh: () =>
                  context.read<UserPresenceCubit>().getUserPresence(
                    widget.token,
                    stateData.data.result!.idUsers!,
                    widget.result,
                  ),
              semanticsLabel: "Pull refresh to get data",
              semanticsValue: "Akan diproses",
              color: Colors.lightBlue,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15.r),
                          bottomRight: Radius.circular(15.r),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 50.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 15.w),
                                child: CircleAvatar(radius: 25.r),
                              ),
                              SizedBox(width: 10.w),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 15.h),
                                child: Column(
                                  children: [
                                    Text(data.result?.idFirstName ?? ''),
                                    Text(data.result?.idDepartement ?? ''),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(right: 30.w),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      Assets.notif,
                                      width: 25.w,
                                      height: 20.h,
                                      color: Theme.of(context).canvasColor,
                                    ),
                                    SizedBox(width: 10.w),
                                    BlocBuilder<ThemeDataCubit, ThemeDataState>(
                                      builder: (context, state) {
                                        return GestureDetector(
                                          onTap: () => context
                                              .read<ThemeDataCubit>()
                                              .toogleTheme(),
                                          child: Image.asset(
                                            state is ThemeDataLight
                                                ? Assets.iconThemesDark
                                                : Assets.iconThemesLight,
                                            width: 25.w,
                                            height: 20.h,
                                            color: Theme.of(
                                              context,
                                            ).canvasColor,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
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

                                final safeDate = DateTime.utc(
                                  p0.year,
                                  p0.month,
                                  p0.day,
                                  p0.hour,
                                  p0.minute,
                                  p0.second,
                                  p0.millisecond,
                                );

                                final formatted = safeDate.toIso8601String();

                                context.read<UserPresenceCubit>().getUserByDate(
                                  widget.token,
                                  stateData.data.result!.idUsers!,
                                  formatted,
                                );
                              });
                            },
                          ),
                          SizedBox(height: 50.h),
                        ],
                      ),
                    ),

                    SizedBox(height: 15.h),
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
                        if (kDebugMode) {
                          debugPrint("State sekarang $state");
                        }
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
                                color: Theme.of(context).colorScheme.surface,
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
                                color: Theme.of(context).colorScheme.surface,
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
                                              Assets.iconCheckOut,
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
                                color: Theme.of(context).colorScheme.surface,
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
                                              Assets.iconBreakTime,
                                              width: 20.w,
                                              height: 20.h,
                                            ),
                                          ),
                                        ),
                                      ),

                                      Text("Break Time"),
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
                                          ? "Avg Time"
                                          : "N/A",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            BlocBuilder<
                              TotalWorkerDartCubit,
                              DataState<DataTotalWorker>
                            >(
                              builder: (context, state) {
                                final data = state.data;
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surface,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.r),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              width: 35.w,
                                              height: 35.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),

                                                color: Colors.lightBlue.shade50,
                                              ),
                                              child: Center(
                                                child: Image.asset(
                                                  Assets.iconBreakTime,
                                                  width: 20.w,
                                                  height: 20.h,
                                                ),
                                              ),
                                            ),
                                          ),

                                          Text("Total Days"),
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
                                              ? "${data?.totalWorker.totalDayWorking} ?? N/A"
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
                                              ? "Working Days"
                                              : "N/A",
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
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
                          padding: EdgeInsets.only(right: 20.w),
                          child: Text(
                            "View All",
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ),
                      ],
                    ),

                    BlocBuilder<UserPresenceCubit, DataState<DataPresence>>(
                      builder: (context, state) {
                        final presence = state.data;
                        return GridView.count(
                          mainAxisSpacing: 16.h,
                          crossAxisCount: 1,
                          childAspectRatio: 3.5,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(20),
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.r),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          width: 45.w,
                                          height: 45.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),

                                            color: Colors.lightBlue.shade50,
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              Assets.iconCheckin,
                                              width: 25.w,
                                              height: 25.h,
                                            ),
                                          ),
                                        ),
                                      ),

                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 5.w),
                                            child: Text(
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              presence?.result.checkIn != null
                                                  ? "Check In"
                                                  : "N/A",
                                            ),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 10.w,
                                            ),
                                            child: Text(
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              presence?.result.checkIn != null
                                                  ? "${DateFormat('d MMMM', 'id_ID').format(presence!.result.checkIn)}.${presence.result.checkIn.year}"
                                                  : "N/A",
                                            ),
                                          ),
                                        ],
                                      ),

                                      Spacer(),

                                      Padding(
                                        padding: EdgeInsets.only(right: 20.w),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 10.w,
                                              ),
                                              child: Text(
                                                style: TextStyle(
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                presence?.result.checkIn != null
                                                    ? "${presence?.result.checkIn.hour}:${presence?.result.checkIn.minute} pm"
                                                    : "N/A",
                                              ),
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 10.w,
                                              ),
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
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.r),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          width: 45.w,
                                          height: 45.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),

                                            color: Colors.lightBlue.shade50,
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              Assets.iconCheckOut,
                                              width: 25.w,
                                              height: 25.h,
                                            ),
                                          ),
                                        ),
                                      ),

                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 5.w),
                                            child: Text(
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              presence?.result.checkOut != null
                                                  ? "Check Out"
                                                  : "N/A",
                                            ),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 10.w,
                                            ),
                                            child: Text(
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              presence?.result.checkOut != null
                                                  ? "${DateFormat('d MMMM', 'id_ID').format(presence!.result.checkOut!)}.${presence.result.checkOut?.year}"
                                                  : "N/A",
                                            ),
                                          ),
                                        ],
                                      ),

                                      Spacer(),

                                      Padding(
                                        padding: EdgeInsets.only(right: 20.w),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 10.w,
                                              ),
                                              child: Text(
                                                style: TextStyle(
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                presence?.result.checkOut !=
                                                        null
                                                    ? "${presence?.result.checkOut?.hour}:${presence?.result.checkOut?.minute} pm"
                                                    : "N/A",
                                              ),
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 10.w,
                                              ),
                                              child: Text(
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                                presence?.result.checkOut !=
                                                        null
                                                    ? "Go Home"
                                                    : "N/A",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    BlocConsumer<PresenceCubit, DataState>(
                      listener: (context, state) {
                        if (state is DataSucces) {
                          context.read<UserPresenceCubit>().getUserPresence(
                            widget.token,
                            stateData.data.result!.idUsers!,
                            widget.result,
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
                                    : presence?.result.status == "OUT"
                                    ? Colors.grey
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
                                      ? context
                                            .read<TotalWorkerDartCubit>()
                                            .dataTotalWorker(
                                              stateData.data.result!.idUsers!,
                                              widget.token,
                                            )
                                      : context
                                            .read<PresenceCubit>()
                                            .sendCheckIn(
                                              widget.token,
                                              stateData.data.result!.idUsers!,
                                            );
                                },
                                enabled: presence?.result.status == "OUT"
                                    ? false
                                    : true,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
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
