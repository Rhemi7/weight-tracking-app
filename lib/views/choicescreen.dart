import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logisticstrackerapp/constants.dart';
import 'file:///C:/Users/Adele%20Fatai/AndroidStudioProjects/FlutterProjects/logistics-tracker/lib/views/shipperscreen.dart';

import 'shipperlogin.dart';
import 'signup.dart';

class ChoiceScreen extends StatefulWidget {
  @override
  _ChoiceScreenState createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Account Type'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RaisedButton(
                color: Colors.green,
                child: Text(
                  'LOGIN AS SHIPPER',
                  textAlign: TextAlign.center,
                  style: kChoiceScreenTextStyle,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShipperLogin(),
                    ),
                  );
                },
              ),
              RaisedButton(
                  color: Colors.green,
                  child: Text(
                    'LOGIN AS RECIPIENT',
                    textAlign: TextAlign.center,
                    style: kChoiceScreenTextStyle,
                  ),
                  onPressed: () {}),
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
                    style: kChoiceScreenTextStyle,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ),
                    );
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
