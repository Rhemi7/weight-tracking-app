import 'dart:async';
import 'package:flutter/material.dart';
import 'package:logisticstrackerapp/Theme/appThemeData.dart';
import 'package:logisticstrackerapp/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashTimer();
  }

  splashTimer() async {
    var duration = Duration(seconds: 3);
    return new Timer(duration, () {
      Navigator.pushNamed(context, RouteNames.onBoardingScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
//    ScreenUtil.init(context, width: 375, height: 812, allowFontScaling: true);
    return initScreen(context);
  }

  initScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: appThemeData.splashColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset('images/scale.png'),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Weight Tracker',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Open Sans',
                  fontSize: 32,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
