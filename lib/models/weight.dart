import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WeightDetails {
  int weight;
  DateTime date;
  TimeOfDay time;
  String documentId;

  WeightDetails({
    this.weight,
    this.date,
    this.time,
  });

  // formatting for upload to Firebase when creating the weight
  Map<String, dynamic> toJson() => {
        'weight': weight,
        'date': date,
        'time': time,
      };

  WeightDetails.fromSnapshot(DocumentSnapshot snapshot)
      : weight = snapshot["weight"],
        date = snapshot['date'].toDate(),
        time = snapshot['time'],
        documentId = snapshot.documentID;
}
