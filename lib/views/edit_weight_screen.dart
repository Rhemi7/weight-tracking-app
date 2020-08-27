import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logisticstrackerapp/Theme/appThemeData.dart';
import 'package:logisticstrackerapp/database/database.dart';
import 'package:logisticstrackerapp/models/weight.dart';
import 'package:logisticstrackerapp/routes/routes.dart';
import 'package:logisticstrackerapp/size_config/config.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class EditWeightScreen extends StatefulWidget {
  final WeightDetails weightToEdit;
  EditWeightScreen({this.weightToEdit});

  @override
  _EditWeightScreenState createState() => _EditWeightScreenState();
}

class _EditWeightScreenState extends State<EditWeightScreen> {
//  // Access to cloud firestore
//  final db = Firestore.instance;

  // spinner to show activity is going on
  bool showSpinner = false;

  TextEditingController weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // this init function passes the value of the object's weight to the textfield

    weightController.text = widget.weightToEdit.weight.toString();
  }

  @override
  Widget build(BuildContext context) {
    var db = Provider.of<Database>(context);

    return SafeArea(
      child: Scaffold(
        // ModalProgressHud is package for spinner
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
                        // functionality to edit data in firestore using the unique documentID

                        await db.editWeight(
                            documentID: widget.weightToEdit.documentId,
                            weight: weightController.text,
                            date: DateTime.now());

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
