import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logisticstrackerapp/Theme/appThemeData.dart';
import 'package:logisticstrackerapp/models/weight.dart';
import 'package:logisticstrackerapp/routes/routes.dart';
import 'package:logisticstrackerapp/size_config/config.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class EditWeightScreen extends StatefulWidget {
  final WeightDetails weightToEdit;
  EditWeightScreen({this.weightToEdit});

  @override
  _EditWeightScreenState createState() => _EditWeightScreenState();
}

class _EditWeightScreenState extends State<EditWeightScreen> {
  // Access to cloud firestore
  final db = Firestore.instance;

  bool showSpinner = false;

  TextEditingController weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    weightController.text = widget.weightToEdit.weight.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  'Edit your weight',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Config.textSize(context, 7)),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: weightController,
                  autofocus: true,
                ),
                SizedBox(
                  height: Config.yMargin(context, 3),
                ),
                Container(
                  height: Config.yMargin(context, 6.5),
                  decoration: BoxDecoration(
                    border: Border.all(color: appThemeData.buttonColor),
                    borderRadius:
                        BorderRadius.circular(Config.xMargin(context, 1)),
                  ),
                  child: FlatButton(
                    color: appThemeData.primaryColor,
                    onPressed: () async {
                      WeightDetails newWeight = WeightDetails(
                        weight: int.parse(weightController.text),
                        date: DateTime.now(),
                      );

                      setState(() {
                        showSpinner = true;
                      });

                      try {
                        await db
                            .collection("Weight Details")
                            .document(widget.weightToEdit.documentId)
                            .updateData({
                          'weight': int.parse(weightController.text),
                          'date': DateTime.now()
                        });

                        Navigator.pushNamed(context, RouteNames.homeScreen);

                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                          color: appThemeData.primaryColorLight,
                          fontFamily: 'Open Sans',
                          fontSize: Config.textSize(context, 4.375),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
