import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:logisticstrackerapp/Theme/appThemeData.dart';
import 'package:logisticstrackerapp/routes/routes.dart';
import 'package:logisticstrackerapp/services/auth_services.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool obscureText = true;
  bool value = false;

  FocusNode nameNode = new FocusNode();
  FocusNode passwordNode = new FocusNode();
  FocusNode emailNode = new FocusNode();
  String _firstName, _email, _password = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var authServices = Provider.of<AuthServices>(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Welcome To Weight Tracker',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: appThemeData.primaryColorDark),
                      ),
                      SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          text: 'Fill in your details to create an account',
                          style: TextStyle(
                              color: appThemeData.primaryColorDark,
                              fontSize: 17),
                        ),
                      ),
                      SizedBox(height: 60),
                      Text(
                        'First Name',
                        style: TextStyle(
                            color: nameNode.hasFocus
                                ? appThemeData.primaryColor
                                : Colors.black87,
                            fontSize: 15),
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        style: TextStyle(
                            color: nameNode.hasFocus
                                ? appThemeData.primaryColor
                                : appThemeData.primaryColorDark),
                        keyboardType: TextInputType.emailAddress,
                        focusNode: nameNode,
                        controller: nameController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: appThemeData.primaryColor, width: 1),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
//                        validator: (firstName) =>
//                            EmailValidator.validate(firstName)
//                                ? null
//                                : "Invalid email address",
                        onSaved: (name) => _firstName = name,
//                        onFieldSubmitted: (_) {
//                          fieldFocusChange(context, emailNode, passwordNode);
//                        },
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Email Address',
                        style: TextStyle(
                            color: emailNode.hasFocus
                                ? appThemeData.primaryColor
                                : Colors.black87,
                            fontSize: 15),
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        style: TextStyle(
                            color: emailNode.hasFocus
                                ? appThemeData.primaryColor
                                : appThemeData.primaryColorDark),
                        keyboardType: TextInputType.emailAddress,
                        focusNode: emailNode,
                        controller: emailController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: appThemeData.primaryColor, width: 1),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (email) => EmailValidator.validate(email)
                            ? null
                            : "Invalid email address",
                        onSaved: (email) => _email = email,
                        onFieldSubmitted: (_) {
                          fieldFocusChange(context, emailNode, passwordNode);
                        },
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Password',
                        style: TextStyle(
                            color: passwordNode.hasFocus
                                ? appThemeData.primaryColor
                                : Colors.black87,
                            fontSize: 15),
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        obscureText: obscureText,
                        style: TextStyle(
                            color: passwordNode.hasFocus
                                ? appThemeData.primaryColor
                                : appThemeData.primaryColorDark),
                        focusNode: passwordNode,
                        controller: passwordController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: appThemeData.primaryColor, width: 1),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.remove_red_eye,
                                color: appThemeData.primaryColorDark),
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                        validator: (password) {
                          Pattern pattern =
                              r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                          RegExp regex = new RegExp(pattern);
                          if (!regex.hasMatch(password))
                            return 'Password must contain at least one letter, one number \nand must be greater than six charaters';
                          else
                            return null;
                        },
                        onSaved: (password) => _password = password,
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 26,
                                  child: Checkbox(
                                    activeColor: appThemeData.buttonColor,
                                    value: value,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        value = newValue;
                                      });
                                    },
                                  ),
                                ),
                                Text(
                                  'Remember Me',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Forgot Password?',
                            style: TextStyle(color: appThemeData.primaryColor),
                          )
                        ],
                      ),
                      SizedBox(height: 54),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();

                            await authServices.createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text);

                            Navigator.pushNamed(context, RouteNames.homeScreen);
                          }
                        },
                        child: Container(
                          height: 54,
                          child: Center(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: appThemeData.primaryColorLight,
                                  fontSize: 15),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: appThemeData.buttonColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
