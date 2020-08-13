import 'dart:math';
import 'updateorder_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Adele%20Fatai/AndroidStudioProjects/FlutterProjects/logistics_tracker_app/lib/views/createorder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShipperDashboard extends StatefulWidget {
  final String name;

  ShipperDashboard({this.name});

  @override
  _ShipperDashboardState createState() => _ShipperDashboardState();
}

class _ShipperDashboardState extends State<ShipperDashboard> {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  FirebaseUser loggedInUser;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.displayName);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Dashboard'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 9,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Text('WELCOME, ${widget.name}'),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text('View Your Shipping History Here'),
                  StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('Order Details').snapshots(),
                    // ignore: missing_return
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final orders = snapshot.data.documents;
                        List<OrderContainer> orderContainers = [];
                        for (var order in orders) {
                          final orderShipper = order.data['shipper'];
                          final orderProdType = order.data['prodType'];
                          final orderProdDesc = order.data['prodDesc'];
                          final orderCurrentDate = order.data['currentDate'];
                          final orderDispatchDate = order.data['dispatchDate'];
                          final orderDeliveryDate = order.data['deliveryDate'];
                          final orderRecipientName =
                              order.data['recipientName'];
                          final orderDispatchLoc = order.data['dispatchLoc'];
                          final orderDeliveryLoc = order.data['deliveryLoc'];
                          final orderCurrentLoc = order.data['currentLoc'];
                          final orderDeliveryStatus =
                              order.data['deliveryStatus'];

                          final orderContainer = OrderContainer(
                            shipper: orderShipper,
                            prodType: orderProdType,
                            prodDesc: orderProdDesc,
                            dispatchDate: orderDispatchDate,
                            deliveryDate: orderDeliveryDate,
                            currentDate: orderCurrentDate,
                            dispatchLoc: orderDispatchLoc,
                            deliveryLoc: orderDeliveryLoc,
                            currentLoc: orderCurrentLoc,
                            recipientName: orderRecipientName,
                            status: orderDeliveryStatus,
                          );
                          orderContainers.add(orderContainer);
                        }
                        return Expanded(
                          child: ListView(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            children: orderContainers,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          size: 50.0,
                        ),
                        onPressed: () async {
                          var orderSummary = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateOrderScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.edit,
                          size: 50.0,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          size: 50.0,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  deleteData(docId) {
    Firestore.instance
        .collection('Order Details')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}

class OrderContainer extends StatelessWidget {
  OrderContainer(
      {this.shipper,
      this.prodType,
      this.prodDesc,
      this.dispatchDate,
      this.deliveryDate,
      this.recipientName,
      this.currentDate,
      this.dispatchLoc,
      this.deliveryLoc,
      this.currentLoc,
      this.status});

  final String shipper;
  final String prodType;
  final String prodDesc;
  final String dispatchDate;
  final String deliveryDate;
  final String recipientName;
  final String dispatchLoc;
  final String currentLoc;
  final String currentDate;
  final String status;
  final String deliveryLoc;

  updateData(selectedDoc, newValues) {
    Firestore.instance
        .collection('Order Details')
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Material(
            elevation: 8.0,
            color: Colors.blueGrey,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Column(
                children: <Widget>[
                  Text(
                    ' Shipper: $shipper \n Recipient Name: $recipientName \n Type of Product: $prodType \n Product Description: $prodDesc \n Dispatch Date: $dispatchDate \n Date of Last Update: $currentDate \n Expected Date of Delivery: $deliveryDate \n Location of Delivery: $deliveryLoc   \n Current Location of Product: $currentLoc \n Dispatch Location: $dispatchLoc \n Delivery Status: $status',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: FlatButton(
                              color: Colors.green,
                              onPressed: () async {
                                var summary = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateOrderScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Update',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: FlatButton(
                              color: Colors.green,
                              onPressed: () {},
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold),
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
