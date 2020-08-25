import 'package:flutter/material.dart';
import 'package:logisticstrackerapp/Theme/appThemeData.dart';
import 'package:logisticstrackerapp/routes/routes.dart';
import 'package:logisticstrackerapp/size_config/config.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Account Type'),
        backgroundColor: appThemeData.primaryColor,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: Config.yMargin(context, 6.5),
                decoration: BoxDecoration(
                  border: Border.all(color: appThemeData.buttonColor),
                  borderRadius:
                      BorderRadius.circular(Config.xMargin(context, 1)),
                ),
                child: FlatButton(
                  color: appThemeData.primaryColor,
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.homeScreen);
                  },
                  child: Text(
                    'SIGN IN ANONYMOUSLY',
                    style: TextStyle(
                        color: appThemeData.primaryColorLight,
                        fontFamily: 'Open Sans',
                        fontSize: Config.textSize(context, 4.375),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                height: Config.yMargin(context, 2),
              ),
              Container(
                height: Config.yMargin(context, 6.5),
                decoration: BoxDecoration(
                  border: Border.all(color: appThemeData.buttonColor),
                  borderRadius:
                      BorderRadius.circular(Config.xMargin(context, 1)),
                ),
                child: FlatButton(
                  color: appThemeData.primaryColor,
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.login);
                  },
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                        color: appThemeData.primaryColorLight,
                        fontFamily: 'Open Sans',
                        fontSize: Config.textSize(context, 4.375),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
//              RaisedButton(
//                  color: Colors.green,
//                  child: Text(
//                    'LOGIN AS RECIPIENT',
//                    textAlign: TextAlign.center,
//                    style: TextStyle(fontSize: 20.0, color: Colors.black),
//                  ),
//                  onPressed: () {}),
              SizedBox(height: 10.0),
              Text(
                'Or, Don\'t Have An Account?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: FlatButton(
                  color: Colors.blueGrey,
                  child: Text(
                    'CREATE AN ACCOUNT',
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.signUp);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
