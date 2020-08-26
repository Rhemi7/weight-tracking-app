import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logisticstrackerapp/Theme/appThemeData.dart';
import 'package:logisticstrackerapp/models/weight.dart';
import 'package:logisticstrackerapp/routes/routes.dart';
import 'package:logisticstrackerapp/services/auth_services.dart';
import 'package:logisticstrackerapp/size_config/config.dart';
import 'package:logisticstrackerapp/views/single_weight_screen.dart';
import 'package:provider/provider.dart';
import 'add_weight_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//  Stream<QuerySnapshot> getWeightsStreamSnapshots(BuildContext context) async* {
//    final uid = await Provider.of<AuthServices>(context).getCurrentUserID();
//
//    yield* Firestore.instance
//        .collection("userData")
//        .document(uid)
//        .collection("Weight Details")
//        .orderBy("date")
//        .snapshots();
//
//    print(getWeightsStreamSnapshots(context));
//  }

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
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              'SignOut',
              style: TextStyle(fontSize: 20),
            ),
          ),
          IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: appThemeData.primaryColorLight,
              ),
              onPressed: () {
                try {
                  Provider.of<AuthServices>(context, listen: false).signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteNames.login, (route) => true);
                } catch (e) {
                  print(e);
                }
              })
        ],
      ),
      body: Container(
        child: StreamBuilder(
            stream: Firestore.instance
                .collection("Weight Details")
                .orderBy("date")
                .snapshots(),
            // ignore: missing_return
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) =>
                        weightCard(context, snapshot.data.documents[index]));
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
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
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SingleWeightScreen(singleWeightDetails: weight)),
          );
        },
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
                          '${weight.weight.toString()} KG',
                          style: TextStyle(
                              fontSize: Config.textSize(context, 4.07),
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '${DateFormat('MM/dd/yyyy').format(weight.date).toString()}',
                              style: TextStyle(
                                  fontSize: Config.textSize(context, 4.6),
                                  color: Colors.grey),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
