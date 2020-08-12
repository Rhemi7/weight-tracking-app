import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:logisticstrackerapp/shipperscreen.dart';
//

final _auth = FirebaseAuth.instance;

Future<String> getCurrentUID() async {
  return (await _auth.currentUser()).uid;
}
////class DatabaseService {
////  final String uid;
////
////  DatabaseService({this.uid});
////  // collection reference
////
////  final CollectionReference orderDetailsCollection =
////      Firestore.instance.collection('Order Details');
////
////  Future updateOrderDetails(
////      String shipper,
////      String deliveryMan,
////      String prodType,
////      String prodDesc,
////      String dispatchDate,
////      String deliveryDate,
////      String recipientName,
////      String currentLoc,
////      String deliveryLoc) async {
////    return await orderDetailsCollection.document(uid).setData({
////      'Shipper': shipper,
////      'Delivery Man': deliveryMan,
////      'Product Type': prodType,
////      'Brief Description': prodDesc,
////      'Dispatch Date': dispatchDate,
////      'Delivery Date': deliveryDate,
////      'Recipient Name': recipientName,
////      'Current Location': currentLoc,
////      'Delivery Location': deliveryLoc,
////    });
////  }
////}
//
//class UserManagement {
//  storeNewUser(user, context) {
//    Firestore.instance.collection('Users').add({
//      'Email': user.email,
//      'uid': user.uid,
//      'First Name': user.firstName,
//      'Last Name': user.lastName,
//      'Phone Number': user.phoneNumber,
//    }).then((value) {
//      Navigator.of(context).pop();
//      Navigator.of(context).pushReplacementNamed('Shipper_Dashboard');
//    }).catchError((e) {
//      print(e);
//    });
//  }
//}
//
//class OrderDetails {
//  bool isLoggedIn() {
//    if (FirebaseAuth.instance.currentUser() != null) {
//      return true;
//    } else {
//      return false;
//    }
//  }
//
//  Future<void> addDate(orderDetails) async {
//    if (isLoggedIn()) {
//      Firestore.instance
//          .collection('Order Details')
//          .add(orderDetails)
//          .catchError((e) {
//        print(e);
//      });
//    } else {
//      print('You need to be logged in');
//    }
//  }
//}
