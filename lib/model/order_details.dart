class OrderDetails {
  String shipper;
  String prodType;
  String prodDesc;
  String dispatchDate;
  String deliveryDate;
  String recipientName;
  String dispatchLoc;
  String currentLoc;
  String deliveryLoc;
  String deliveryStatus;
  String currentDate;

  OrderDetails(
      {this.shipper,
      this.prodType,
      this.prodDesc,
      this.dispatchDate,
      this.deliveryDate,
      this.recipientName,
      this.dispatchLoc,
      this.currentLoc,
      this.deliveryLoc,
      this.currentDate});

  Map<String, dynamic> toJson() => {
        'shipper': shipper,
        'prodType': prodType,
        'prodDesc': prodDesc,
        'dispatchDate': dispatchDate,
        'deliveryDate': deliveryDate,
        'recipientName': recipientName,
        'dispatchLoc': dispatchLoc,
        'deliveryLoc': deliveryLoc,
        'currentLoc': currentLoc,
        'deliveryStatus': deliveryStatus,
        'currentDate': currentDate
      };
}
