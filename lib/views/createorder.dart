import 'package:flutter/material.dart';
import 'package:logisticstrackerapp/constants.dart';
import 'package:logisticstrackerapp/model/order_details.dart';
import '../database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../shipperscreen.dart';
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

  TextEditingController shipperController = TextEditingController();
  TextEditingController currentDateController = TextEditingController();
  TextEditingController prodTypeController = TextEditingController();
  TextEditingController prodDescController = TextEditingController();
  TextEditingController dispatchDateController = TextEditingController();
  TextEditingController deliveryDateController = TextEditingController();
  TextEditingController recipientNameController = TextEditingController();
  TextEditingController dispatchLocController = TextEditingController();
  TextEditingController deliveryLocController = TextEditingController();
  TextEditingController currentLocController = TextEditingController();
  TextEditingController statusController = TextEditingController();

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
    OrderDetails order = OrderDetails();

    order.shipper = shipperController.text;
    order.prodType = prodTypeController.text;
    order.prodDesc = prodDescController.text;
    order.dispatchDate = dispatchDateController.text;
    order.dispatchLoc = dispatchLocController.text;
    order.deliveryDate = deliveryDateController.text;
    order.deliveryLoc = deliveryDateController.text;
    order.recipientName = recipientNameController.text;
    order.currentLoc = currentLocController.text;
    order.deliveryStatus = statusController.text;

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
//                    onChanged: (value) {
//                      shipper = value;
//                      print(shipper);
//                    },
                    controller: shipperController,
                    obscureText: false,
                    decoration:
                        kTextFieldDecoration.copyWith(labelText: "Shipper"),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
//                    onChanged: (value) {
//                      prodType = value;
//                      print(prodType);
//                    },
                    controller: prodTypeController,
                    obscureText: false,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: "Type of Product"),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
//                    onChanged: (value) {
//                      prodDesc = value;
//                      print(prodDesc);
//                    },
                    controller: prodDescController,
                    obscureText: false,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: "Product Description"),
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(height: 8.0),
                  TextField(
//                    onChanged: (value) {
//                      currentDate = value;
//                      print(currentDate);
//                    },
                    controller: currentDateController,
                    obscureText: false,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: "Current Date"),
                    keyboardType: TextInputType.datetime,
                  ),
                  SizedBox(height: 8.0),
                  TextField(
//                    onChanged: (value) {
//                      dispatchDate = value;
//                      print(dispatchDate);
//                    },
                    controller: dispatchDateController,
                    obscureText: false,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: "Dispatch Date"),
                    keyboardType: TextInputType.datetime,
                  ),
                  SizedBox(height: 8.0),
                  TextField(
//                    onChanged: (value) {
//                      deliveryDate = value;
//                      print(deliveryDate);
//                    },
                    controller: deliveryDateController,
                    obscureText: false,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: "Expected Date of Delivery"),
                    keyboardType: TextInputType.datetime,
                  ),
                  SizedBox(height: 8.0),
                  TextField(
//                    onChanged: (value) {
//                      recipientName = value;
//                      print(recipientName);
//                    },
                    controller: recipientNameController,
                    obscureText: false,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: "Name of Recipient"),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
//                    onChanged: (value) {
//                      dispatchLoc = value;
//                      print(dispatchLoc);
//                    },
                    controller: dispatchLocController,
                    obscureText: false,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: "Dispatch Location"),
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(height: 8.0),
                  TextField(
//                    onChanged: (value) {
//                      deliveryLoc = value;
//                      print(deliveryLoc);
//                    },
                    controller: deliveryLocController,
                    obscureText: false,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: "Delivery Date"),
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(height: 8.0),
                  TextField(
//                    onChanged: (value) {
//                      currentLoc = value;
//                      print(currentLoc);
//                    },
                    controller: currentLocController,
                    obscureText: false,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: "Current Location"),
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(height: 8.0),
                  TextField(
//                    onChanged: (value) {
//                      status = value;
//                      print(status);
//                    },
                    controller: statusController,
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
                  _firestore.collection('Order Details').add(order.toJson());
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
