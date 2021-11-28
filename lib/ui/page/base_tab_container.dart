import 'package:flutter/material.dart';
import 'package:mood/data/service/auth/authentication_repository.dart';
import 'package:mood/ui/nav/bottom_navigation.dart';
import 'package:mood/ui/nav/menu.dart';
import 'package:mood/ui/router.dart';
import 'package:provider/src/provider.dart';

class BaseTabContainer extends StatefulWidget {
  const BaseTabContainer({Key? key}) : super(key: key);

  @override
  BaseTabContainerState createState() => BaseTabContainerState();
}

class BaseTabContainerState extends State<BaseTabContainer> {
  int _currentTab = 1;
  final PageController _pageController = PageController(initialPage: 1);
  final GlobalKey<BottomNavigationState> _bottomNavState =
      GlobalKey<BottomNavigationState>();

  void _onTapped(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void onPageChanged(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationRepository auth = context.read<AuthenticationRepository>();
    MoodRouter router = MoodRouter();
    Menu menu = Menu(auth: auth);

    return Scaffold(
      appBar: AppBar(
        title: Text(BottomNavigation.tabs[_currentTab].name),
        centerTitle: true,
        actions: <Widget>[
          menu.buildMenu(context),
        ],
      ),
      body: PageView(
        children: BottomNavigation.tabs.map((tab) {
          return Navigator(
            key: tab.nav,
            onGenerateRoute: router.generateRoute,
            initialRoute: tab.route,
          );
        }).toList(),
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
      bottomNavigationBar: BottomNavigation(
        currentTab: _currentTab,
        onTapped: _onTapped,
        key: _bottomNavState,
      ),
    );
  }
}
