import 'package:flutter/material.dart';
import 'package:logisticstrackerapp/choicescreen.dart';
import 'package:logisticstrackerapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logisticstrackerapp/shipperscreen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _auth = FirebaseAuth.instance;

  bool showSpinner = false;

  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String password;
  String confirmPassword;

  var _category = [
    "Shipper",
    "Recipient",
  ];
  var _currentItemSelected = "Shipper";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SIGN UP'),
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
                    'WE ARE GLAD TO HAVE YOU',
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0),
                  ),
                ),
              ),
              Container(
                child: Image.asset('images/signup.png'),
                width: 100,
                height: 50,
              ),
              SizedBox(height: 10),
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
                    onChanged: (value) {
                      lastName = value;
                    },
                    obscureText: false,
                    decoration:
                        kTextFieldDecoration.copyWith(hintText: "Last Name")),
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
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    phoneNumber = value;
                  },
                  obscureText: false,
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: "Phone Number"),
                ),
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
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                    onChanged: (value) {
                      confirmPassword = value;
                    },
                    obscureText: true,
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: "Confirm Password")),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  items: _category.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),
                  onChanged: (String newValueSelected) {
                    setState(() {
                      this._currentItemSelected = newValueSelected;
                    });
                  },
                  value: _currentItemSelected,
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
                          'SIGN UP',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email, password: password);
                            if (newUser != null) {
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
//                        print(email);
//                        print(password);
//                        print(firstName);
//                        print(lastName);
//                        print(_currentItemSelected);
//                        print(confirmPassword);
//                        print(phoneNumber);
//                        print('User is REGISTERED');
                        },
                      ),
                    ),
                    Text(
                      'DO YOU HAVE AN ACCOUNT?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FlatButton(
                        color: Colors.blueGrey,
                        child: Text(
                          'PROCEED TO LOGIN',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChoiceScreen(),
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
