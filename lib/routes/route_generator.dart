import 'package:flutter/material.dart';
import 'package:logisticstrackerapp/views/home_screen.dart';
import 'package:logisticstrackerapp/views/log_in_screen.dart';
import 'package:logisticstrackerapp/views/onboarding_screen.dart';
import 'package:logisticstrackerapp/views/sign_up_screen.dart';
import 'package:logisticstrackerapp/views/splash_screen.dart';
import 'page_transition.dart';
import 'routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return CustomSlideTransition(child: SplashScreen());
        break;
      case RouteNames.onBoardingScreen:
        return CustomSlideTransition(child: OnBoardingScreen());
        break;
      case RouteNames.signUp:
        return CustomSlideTransition(child: SignUpScreen());
        break;
      case RouteNames.login:
        return CustomSlideTransition(child: LoginScreen());
        break;
      case RouteNames.homeScreen:
        return CustomSlideTransition(child: HomeScreen());
        break;
    }
  }
}
