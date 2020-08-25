import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logisticstrackerapp/Theme/appThemeData.dart';
import 'package:logisticstrackerapp/models/weight.dart';
import 'package:logisticstrackerapp/services/auth_services.dart';
import 'package:logisticstrackerapp/size_config/config.dart';
import 'package:provider/provider.dart';

import 'add_weight_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream<QuerySnapshot> getWeightsStreamSnapshots(BuildContext context) async* {
    final uid = await Provider.of<AuthServices>(context).getCurrentUserID();

    yield* Firestore.instance
        .collection('userData')
        .document(uid)
        .collection('Weight Details')
        .orderBy('date')
        .snapshots();
  }

  _getWeights(BuildContext context) async {
    final uid = await Provider.of<AuthServices>(context).getCurrentUserID();
    var snapshot = await Firestore.instance
        .collection('userData')
        .document(uid)
        .collection('Weight Details')
        .orderBy('date')
        .limit(1)
        .getDocuments();
    return WeightDetails.fromSnapshot(snapshot.documents.first);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: appThemeData.primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(context: context, builder: buildBottomSheet);
        },
      ),
      appBar: AppBar(
        backgroundColor: appThemeData.primaryColor,
        title: Text('Home Screen'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: appThemeData.primaryColorLight,
              ),
              onPressed: null)
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: _getWeights(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                // Display Welcome
                return Text('first');
              } else {
                return showHomePageWithTrips(snapshot.data);
              }
            } else {
              return Text("Loading...");
            }
          },
        ),
      ),
    );
  }

  Widget showHomePageWithTrips(WeightDetails weightDetails) {
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder(
              stream: getWeightsStreamSnapshots(context),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text("Input your weight");
                return new ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) =>
                        weightCard(context, snapshot.data.documents[index]));
              }),
        ),
      ],
    );
  }

  Widget buildBottomSheet(BuildContext context) => AddWeightScreen();
}

Widget weightCard(BuildContext context, DocumentSnapshot document) {
  final weight = WeightDetails.fromSnapshot(document);

  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        height: Config.yMargin(context, 16.7),
        width: Config.xMargin(context, 79),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: appThemeData.primaryColorLight),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Row(
                children: <Widget>[
                  Container(
                    height: Config.yMargin(context, 7.90),
                    width: Config.xMargin(context, 12.72),
                    child: Image.asset('images/scale.png'),
                  ),
                  Container(
                    height: Config.yMargin(context, 5.27),
                    child: VerticalDivider(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        '${weight.weight} KG',
                        style: TextStyle(
                            fontSize: Config.textSize(context, 4.07),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Completed',
                        style: TextStyle(color: Colors.blue.shade900),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            weight.time.toString(),
                            style: TextStyle(
                                fontSize: Config.textSize(context, 4.6),
                                color: Colors.grey),
                          ),
                          SizedBox(
                            width: Config.xMargin(context, 5.04),
                          ),
                          Text(
//                            '19th July, 2020',
                            '${DateFormat('MM/dd/yyyy').format(weight.date).toString()}',
                            style: TextStyle(
                                fontSize: Config.textSize(context, 4.6),
                                color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),

//                    Column(
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: <Widget>[
//                        Container(
//                          child: IconButton(
//                              icon: Icon(
//                                Icons.share,
//                                color: Colors.blue.shade700,
//                                size: 35,
//                              ),
//                              onPressed: () {}),
//                        ),
//                        Text(
//                          'Share',
//                          style: TextStyle(
//                              fontSize: Config.textSize(context, 2.6),
//                              color: Colors.blue.shade700),
//                        ),
//                      ],
//                    ),
                ],
              ),
            ),
//              Divider(),
//              Expanded(
//                flex: 1,
//                child: Container(
//                  padding: EdgeInsets.symmetric(horizontal: 10),
//                  child: Row(
//                    children: <Widget>[
//                      GestureDetector(
//                        onTap: () {},
//                        child: Container(
//                          padding: EdgeInsets.only(left: 10),
//                          child: Text('Accept Badge',
//                              style: TextStyle(
//                                  fontSize: Config.textSize(context, 3.56),
//                                  fontWeight: FontWeight.w600)),
//                        ),
//                      ),
//                      SizedBox(
//                        width: Config.textSize(context, 25.45),
//                      ),
//                      GestureDetector(
//                        onTap: () {},
//                        child: Container(
//                          child: Row(
//                            children: <Widget>[
//                              Icon(
//                                Icons.check,
//                                color: Colors.green,
//                              ),
//                              SizedBox(
//                                width: Config.xMargin(context, 2.6),
//                              ),
//                              Text('Done',
//                                  style: TextStyle(
//                                      fontSize: Config.textSize(context, 3.56),
//                                      fontWeight: FontWeight.w600))
//                            ],
//                          ),
//                        ),
//                      )
//                    ],
//                  ),
//                ),
//              )
          ],
        ),
      ),
    ),
  );
}
