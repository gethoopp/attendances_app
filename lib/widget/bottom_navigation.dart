import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  var activeIndex = 0;

  List<IconData> iconList = [
    Icons.add_ic_call_outlined,
    Icons.ac_unit_sharp,
    Icons.ac_unit,
    Icons.access_alarm_outlined
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: 0,
        onTap: (value) {
          setState(() {
            activeIndex = value;
          });
        },
      ),
    );
  }
}
