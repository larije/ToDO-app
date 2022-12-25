import 'package:todo_prj/util/habit_tracker.dart';
import 'package:todo_prj/util/home_page.dart';
import 'package:todo_prj/util/to_do.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key});

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];

  final myTextStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 23,
    color: Colors.yellow,
  );

  @override
  void initState() {
    super.initState();

    _pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: 'To Do List',
            baseStyle: myTextStyle,
            selectedStyle: myTextStyle,
            colorLineSelected: Color.fromARGB(255, 159, 0, 199),
          ),
          ToDopage()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: 'To Do Tracker',
            baseStyle: myTextStyle,
            selectedStyle: myTextStyle,
            colorLineSelected: Color.fromARGB(255, 255, 99, 52),
          ),
          HabitTrackerPage()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: Color.fromARGB(255, 54, 54, 54),
      screens: _pages,
      initPositionSelected: 0,
      slidePercent: 48,
      contentCornerRadius: 20,
      enableCornerAnimation: true,
    );
  }
}
