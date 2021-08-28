import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sezapp/api/medication_api_service.dart';
import 'package:sezapp/model/Medication.dart';
import 'package:sezapp/screens/patient/reports/medication/medicationActions.dart';
import 'package:sezapp/screens/patient/reports/medication/medicationDetails.dart';

import '../../../../constants.dart';

class AllMedication extends StatefulWidget {
  final userId;

  const AllMedication({Key key, this.userId}) : super(key: key);

  @override
  _AllMedicationState createState() => _AllMedicationState();
}

class _AllMedicationState extends State<AllMedication> {
  Future<List<Medication>> allMed;

  @override
  void initState() {
    allMed = getMedications(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String languageCode = Localizations.localeOf(context).languageCode;
    return Container(
      color: kLightColor,
      child: FutureBuilder<List<Medication>>(
          future: allMed,
          builder: (context, snapshot) {
            return RefreshIndicator(
              // ignore: missing_return
              onRefresh: refreshMedicationList,
              child: _listView(snapshot, languageCode, size),
            );
          }),
    );
  }

  Widget _listView(AsyncSnapshot snapshot, String languageCode, size) {
    if (snapshot.hasData) {
      if (snapshot.data.length == 0) {
        return Container(
          width: size.width,
          height: size.height,
          color: kLightColor,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "No data available!",
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
          ),
        );
      }
      return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.transparent,
            elevation: 0,
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            margin: new EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0),
            child: FocusedMenuHolder(
              menuBoxDecoration: BoxDecoration(
                  color: Color.fromRGBO(158, 152, 152, 0.6),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              duration: Duration(milliseconds: 50),
              animateMenuItems: true,
              menuOffset: 10.0,
              blurBackgroundColor: Color.fromRGBO(158, 152, 152, 0.6),
              blurSize: 5.0,
              menuItems: [
                FocusedMenuItem(
                    title: Text("Favorite"),
                    trailingIcon: Icon(Icons.favorite_border),
                    onPressed: () {}),
                FocusedMenuItem(
                  title: Text(
                    "Delete",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  trailingIcon: Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                  onPressed: () =>
                      showDialogAndDeleteMed(snapshot.data[index].id, context),
                ),
              ],
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                            MedicationDetails(snapshot.data[index])));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.8),
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(143, 148, 251, 0.05),
                          blurRadius: 50.0,
                          offset: Offset(0, 8))
                    ]),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  leading: Icon(
                    LineAwesomeIcons.capsules,
                    color: kPrimaryColor,
                    size: 35,
                  ),
                  title: Text(
                    snapshot.data[index].name,
                    style: TextStyle(color: kPrimaryColor),
                  ),
                  subtitle: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.fromLTRB(0, 3, 8, 3),
                              child: Icon(
                                LineAwesomeIcons.tablets,
                                color: kPrimaryLightColor,
                                size: 17,
                              )),
                          Text(snapshot.data[index].dose),
                          SizedBox(
                            width: 7,
                          ),
                          //Wrap(children: <Widget>[

                          // ]),
                        ],
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right,
                      color: kPrimaryColor, size: 25.0),
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  Future<void> refreshMedicationList() async {
    if (mounted)
      setState(() {
        allMed = getMedications(widget.userId);
      });

    await Future.delayed(Duration(seconds: 2));
  }

  showDialogAndDeleteMed(int id, BuildContext context) {
    final AlertDialog errorDialog = AlertDialog(
      title: Text(
        'Error',
        style: TextStyle(
          color: kRedTextColor,
        ),
      ),
      content: Text('Could not delete this item'),
      actions: [
        // ignore: deprecated_member_use
        FlatButton(
          textColor: kPrimaryColor,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('CANCEL'),
        ),
      ],
    );

    final AlertDialog dialog = AlertDialog(
      title: Text('Delete Medication'),
      content: Text('Are you sure you want to delete this item?'),
      actions: [
        // ignore: deprecated_member_use
        FlatButton(
          textColor: kPrimaryColor,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('CANCEL'),
        ),
        // ignore: deprecated_member_use
        FlatButton(
          textColor: kPrimaryColor,
          onPressed: () async {
            var response = await deleteMedication(id);
            if (!response) {
              showDialog<void>(
                  context: context, builder: (context) => errorDialog);
              return;
            } else {
              Navigator.of(context).pop();
              refreshMedicationList();
            }
          },
          child: Text('ACCEPT'),
        ),
      ],
    );

    showDialog<void>(context: context, builder: (context) => dialog);
  }
}
