import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logisticstrackerapp/models/weight.dart';

class Database extends ChangeNotifier {
  final db = Firestore.instance;

  // this adds the weight data to the database
  Future<void> addWeight(WeightDetails details) async {
    await db.collection("Weight Details").add(details.toJson());
  }

  // this edits the weight data in the database
  Future<void> editWeight(
      {String documentID, String weight, DateTime date}) async {
    await db.collection("Weight Details").document(documentID).updateData({
      'weight': int.parse(weight),
      'date': date,
    });
  }

  // this deletes the weight data from the database
  Future<void> deleteWeight(String documentID) async {
    await db.collection("Weight Details").document(documentID).delete();
  }
}
