import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logisticstrackerapp/Theme/appThemeData.dart';
import 'package:logisticstrackerapp/models/weight.dart';
import 'package:logisticstrackerapp/size_config/config.dart';
import 'package:logisticstrackerapp/views/edit_weight_screen.dart';

class SingleWeightScreen extends StatelessWidget {
  final WeightDetails singleWeightDetails;
  final db = Firestore.instance;

  SingleWeightScreen({this.singleWeightDetails});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        color: appThemeData.primaryColor,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Your Weight on ${singleWeightDetails.date}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: Config.textSize(
                    context,
                    9,
                  ),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: Config.yMargin(context, 10),
            ),
            Text(
              'is',
              style: TextStyle(
                fontSize: Config.textSize(context, 15),
              ),
            ),
            SizedBox(
              height: Config.yMargin(context, 10),
            ),
            Text(
              '${singleWeightDetails.weight} KG',
              style: TextStyle(fontSize: Config.textSize(context, 25)),
            ),
            SizedBox(
              height: Config.yMargin(context, 10),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditWeightScreen(
                                  weightToEdit: singleWeightDetails,
                                )),
                      );
                    },
                    child: Container(
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0xFFE2E2E2),
                            child: Image.asset('images/edit.png'),
                          ),
                          Text('Edit')
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await db
                          .collection("Weight Details")
                          .document(singleWeightDetails.documentId)
                          .delete();
                      Navigator.pop(context);
                    },
                    child: Container(
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0xFFFE4F4F),
                            child: Image.asset('images/delete.png'),
                          ),
                          Text('Delete')
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
