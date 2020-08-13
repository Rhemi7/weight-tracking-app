import 'package:flutter/material.dart';

class OrderSummary extends StatefulWidget {
  final String shipper;
  final String name;
  final String prodType;
  final String prodDesc;
  final String dispatchDate;
  final String deliveryDate;
  final String recipientName;
  final String dispatchLoc;
  final String deliveryLoc;

  OrderSummary(
      {this.shipper,
      this.name,
      this.prodType,
      this.prodDesc,
      this.dispatchDate,
      this.deliveryDate,
      this.recipientName,
      this.deliveryLoc,
      this.dispatchLoc});

  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summary'),
      ),
      body: Column(
        children: <Widget>[Text('Shipper name is ${widget.shipper}'), Text('')],
      ),
    );
  }
}
