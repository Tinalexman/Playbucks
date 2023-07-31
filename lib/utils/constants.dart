import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const Color theme = Color.fromARGB(255, 245, 245, 245);
const Color appRed = Color.fromARGB(255, 217, 74, 74);
const Color niceBlue =  Color.fromARGB(255, 73, 121, 209);
const Color possibleGreen = Color.fromARGB(255, 0, 158, 96);
const Color goodYellow = Color.fromARGB(255, 252, 163, 17);
const Color primary = Color.fromARGB(255, 31, 31, 31);
const Color fadedPrimary = Color.fromARGB(25, 31, 31, 31);
const Color midPrimary = Color.fromARGB(255, 65, 65, 65);
const Color neutral = Color.fromARGB(180, 200, 200, 200);
const Color neutral2 = Color.fromARGB(35, 152, 152, 152);
const Color neutral3 = Color.fromARGB(255, 165, 165, 165);
const Color statusColor = Color.fromARGB(255, 229, 229, 229);
const Color offWhite = Color.fromRGBO(224, 224, 224, 1.0);


extension PathExtension on String {
  String get path => "/$this";
}

extension ContextExtension on BuildContext {
  GoRouter get router => GoRouter.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
}

class Pages {

  static const String splash = 'splash';
  static const String onboarding = 'onboarding';
  static const String login = 'login';
  static const String register = 'register';
  static const String artisteDashboard = 'dashboard-artiste';
  static const String listenerDashboard = 'dashboard-listener';
  static const String withdraw = 'withdraw';
  static const String deposit = 'deposit';
  static const String mediaPlayer = 'media-player';
  static const String choose = 'chooser';
}