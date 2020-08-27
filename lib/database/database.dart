import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logisticstrackerapp/models/weight.dart';

class Database extends ChangeNotifier {
  final db = Firestore.instance;

  Future<void> addWeight(WeightDetails details) async {
    await db.collection("Weight Details").add(details.toJson());
  }
}
