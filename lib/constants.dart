import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
    filled: true,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        borderSide: BorderSide.none),
    labelStyle: TextStyle(color: Colors.grey));

const kChoiceScreenTextStyle = TextStyle(fontSize: 20.0, color: Colors.black);
