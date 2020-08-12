import 'package:flutter/material.dart';
import 'package:logisticstrackerapp/constants.dart';
import 'database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'shipperscreen.dart';
import 'signup.dart';

class CreateOrderScreen extends StatefulWidget {
  @override
  _CreateOrderScreenState createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  FirebaseUser loggedInUser;

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

  String shipper;
  String currentDate;
  String prodType;
  String prodDesc;
  String dispatchDate;
  String deliveryDate;
  String recipientName;
  String dispatchLoc;
  String deliveryLoc;
  String currentLoc;
  String status;

//  void getOrder() async {
//    final orderDetails =
//        await _firestore.collection('Order Details').getDocuments();
//    for (var order in orderDetails.documents) {
//      print(order.data);
//    }
//  }

  void orderStream() async {
    await for (var snapshot
        in _firestore.collection('Order Details').snapshots()) {
      for (var order in snapshot.documents) {
        print(order.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Order'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 9,
              child: ListView(
                children: <Widget>[
                  TextField(
                    onChanged: (value) {
                      shipper = value;
                      print(shipper);
                    },
                    obscureText: false,
                    decoration:
                        kTextFieldDecoration.copyWith(labelText: "Shipper"),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    onChanged: (value) {
                      prodType = value;
                      print(prodType);
                    },
                    obscureText: false,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: "Type of Product"),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    onChanged: (value) {
                      prodDesc = value;
                      print(prodDesc);
                    },
                    obscureText: false,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: "Product Description"),
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    onChanged: (value) {
                      currentDate = value;
                      print(currentDate);
                    },
                    obscureText: false,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: "Current Date"),
                    keyboardType: TextInputType.datetime,
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    onChanged: (value) {
                      dispatchDate = value;
                      print(dispatchDate);
                    },
                    obscureText: false,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: "Dispatch Date"),
                    keyboardType: TextInputType.datetime,
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    onChanged: (value) {
                      deliveryDate = value;
                      print(deliveryDate);
                    },
                    obscureText: false,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: "Expected Date of Delivery"),
                    keyboardType: TextInputType.datetime,
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    onChanged: (value) {
                      recipientName = value;
                      print(recipientName);
                    },
                    obscureText: false,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: "Name of Recipient"),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    onChanged: (value) {
                      dispatchLoc = value;
                      print(dispatchLoc);
                    },
                    obscureText: false,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: "Dispatch Location"),
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    onChanged: (value) {
                      deliveryLoc = value;
                      print(deliveryLoc);
                    },
                    obscureText: false,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: "Delivery Location"),
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    onChanged: (value) {
                      currentLoc = value;
                      print(currentLoc);
                    },
                    obscureText: false,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: "Current Location"),
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    onChanged: (value) {
                      status = value;
                      print(status);
                    },
                    obscureText: false,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: "Delivery Status"),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: FlatButton(
                color: Colors.green,
                onPressed: () {
                  _firestore.collection('Order Details').add({
                    'shipper': shipper,
                    'prodType': prodType,
                    'prodDesc': prodDesc,
                    'dispatchDate': dispatchDate,
                    'deliveryDate': deliveryDate,
                    'recipientName': recipientName,
                    'dispatchLoc': dispatchLoc,
                    'deliveryLoc': deliveryLoc,
                    'currentLoc': currentLoc,
                    'deliveryStatus': status,
                    'currentDate': currentDate
                  });
//                Map orderDetails = {
//                  'Shipper': shipper,
//                  'Product Type': prodType,
//                  'Product Description': prodDesc,
//                  'Dispatch Date': dispatchDate,
//                  'Expected Date of Delivery': deliveryDate,
//                  'Recipient Name': recipientName,
//                  'Dispatch Location': dispatchLoc,
//                  'Delivery Location': deliveryLoc
//                };
                  orderStream();
                  Navigator.pop(context, orderStream());
                },
                child: Text('Create Order'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
