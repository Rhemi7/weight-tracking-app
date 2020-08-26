import 'package:flutter/material.dart';
import 'package:logisticstrackerapp/views/add_weight_screen.dart';
import 'package:logisticstrackerapp/views/home_screen.dart';
import 'package:logisticstrackerapp/views/log_in_screen.dart';
import 'package:logisticstrackerapp/views/onboarding_screen.dart';
import 'package:logisticstrackerapp/views/sign_up_screen.dart';
import 'package:logisticstrackerapp/views/single_weight_screen.dart';
import 'package:logisticstrackerapp/views/splash_screen.dart';

class RouteNames {
  //Custom class that holds all the named routes as constants for easy reference
  static const String splashScreen = '/';
  static const String signUp = 'signUp';
  static const String login = 'login';
  static const String homeScreen = 'homeScreen';
  static const String onBoardingScreen = 'onBoardingScreen';
  static const String addWeightScreen = 'addWeightScreen';
  static const String singleWeightScreen = 'singleWeightScreen';

  //Routes and their respective Pages.
  static Map<String, Widget Function(BuildContext)> routes = {
    RouteNames.splashScreen: (context) => SplashScreen(),
    RouteNames.signUp: (context) => SignUpScreen(),
    RouteNames.login: (context) => LoginScreen(),
    RouteNames.homeScreen: (context) => HomeScreen(),
    RouteNames.onBoardingScreen: (context) => OnBoardingScreen(),
    RouteNames.addWeightScreen: (context) => AddWeightScreen(),
    RouteNames.singleWeightScreen: (context) => SingleWeightScreen()
  };
}
