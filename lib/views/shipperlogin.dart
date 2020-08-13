import 'package:flutter/material.dart';
import 'package:logisticstrackerapp/constants.dart';
import 'file:///C:/Users/Adele%20Fatai/AndroidStudioProjects/FlutterProjects/logistics_tracker_app/lib/views/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../shipperscreen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ShipperLogin extends StatefulWidget {
  @override
  _ShipperLoginState createState() => _ShipperLoginState();
}

class _ShipperLoginState extends State<ShipperLogin> {
  final _auth = FirebaseAuth.instance;

  bool showSpinner = false;
  String email;
  String password;
  String firstName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView(
            children: <Widget>[
              Container(
                child: Center(
                  child: Text(
                    'WELCOME!',
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 50.0),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    'PLEASE LOGIN',
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0),
                  ),
                ),
              ),
              Container(
                child: Image.asset('images/login.png'),
                width: 100,
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    firstName = value;
                  },
                  obscureText: false,
                  decoration:
                      kTextFieldDecoration.copyWith(labelText: "First Name"),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                      print(email);
                    },
                    obscureText: false,
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: "Email Address")),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    password = value;
                    print(password);
                  },
                  obscureText: true,
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: "Password"),
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FlatButton(
                        color: Colors.green,
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email, password: password);

                            if (user != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShipperDashboard(
                                    name: firstName,
                                  ),
                                ),
                              );
                            }
                            setState(() {
                              showSpinner = false;
                            });
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                    ),
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
