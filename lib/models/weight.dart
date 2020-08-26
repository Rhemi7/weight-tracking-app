import 'package:cloud_firestore/cloud_firestore.dart';

class WeightDetails {
  int weight;
  DateTime date;
  // this id will be used to get the unique document id from firestore for either editing or deleting of the data
  String documentId;

  WeightDetails({
    this.weight,
    this.date,
  });

  // formatting for upload to Firebase when creating the weight
  Map<String, dynamic> toJson() => {
        'weight': weight,
        'date': date,
      };

  WeightDetails.fromSnapshot(DocumentSnapshot snapshot)
      : weight = snapshot["weight"],
        date = snapshot['date'].toDate(),
        documentId = snapshot.documentID;
}
