import 'package:flutter/material.dart';
import 'package:mood/constants/strings.dart';

class TabItem {
  final Widget icon;
  final String name;
  final String route;
  final GlobalKey<NavigatorState> nav = GlobalKey<NavigatorState>();

  TabItem({required this.icon, required this.name, required this.route});
}

class BottomNavigation extends StatefulWidget {
  static final tabs = [
    TabItem(
      icon: const Icon(Icons.home_rounded),
      name: home,
      route: homeRoute,
    ),
    TabItem(
      icon: const Icon(Icons.list_rounded),
      name: survey,
      route: surveyRoute,
    ),
    TabItem(
      icon: const Icon(Icons.bar_chart_rounded),
      name: analytics,
      route: analyticsRoute,
    )
  ];

  const BottomNavigation(
      {required Key key, required this.currentTab, required this.onTapped})
      : super(key: key);
  final int currentTab;
  final ValueChanged<int> onTapped;

  @override
  BottomNavigationState createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentTab,
      items: BottomNavigation.tabs.map((tab) {
        return BottomNavigationBarItem(icon: tab.icon, label: tab.name);
      }).toList(),
      type: BottomNavigationBarType.fixed,
      onTap: (index) => widget.onTapped(index),
    );
  }
}
