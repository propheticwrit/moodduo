import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood/constants/strings.dart';
import 'package:mood/ui/page/analytics/analytics_page.dart';
import 'package:mood/ui/page/analytics/cubit/analytics_cubit.dart';
import 'package:mood/ui/page/base_tab_container.dart';
import 'package:mood/ui/page/configuration/base/configuration_page.dart';
import 'package:mood/ui/page/configuration/base/cubit/configuration_cubit.dart';
import 'package:mood/ui/page/daily/cubit/daily_cubit.dart';
import 'package:mood/ui/page/daily/daily_page.dart';
import 'package:mood/ui/page/home/cubit/home_cubit.dart';
import 'package:mood/ui/page/home/home_page.dart';
import 'package:mood/ui/page/login/firebase/login_page.dart';

class MoodRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => HomeCubit(),
                  child: const HomePage(),
                ));
      case dailyRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => DailyCubit(),
                  child: const DailyPage(),
                ));
      case analyticsRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AnalyticsCubit(),
                  child: const AnalyticsPage(),
                ));
      case configurationRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ConfigurationCubit(),
                  child: ConfigurationPage(),
                ));
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      default:
        return MaterialPageRoute(builder: (_) => const BaseTabContainer());
    }
  }
}
