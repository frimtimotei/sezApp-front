import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:focused_menu/modals.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sezapp/Screens/Patient/Reports/Seizures/seizure_details.dart';
import 'package:sezapp/Screens/Patient/Reports/Seizures/seziuresActions.dart';
import 'package:sezapp/api/seizure_api_service.dart';
import 'package:sezapp/constants.dart';
import 'package:sezapp/model/Seizure.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:focused_menu/focused_menu.dart';

class AllSeizures extends StatefulWidget {
  final userId;
  const AllSeizures({Key key,this.userId}) : super(key: key);

  @override
  _AllSeizuresState createState() => _AllSeizuresState();
}

class _AllSeizuresState extends State<AllSeizures> {
  Future<List<Seizure>> allSez;

  @override
  void initState() {
    super.initState();
    allSez = getSeizures(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    initializeDateFormatting();
    String languageCode = Localizations.localeOf(context).languageCode;
    return Container(
      color: kLightColor,
      child: FutureBuilder<List<Seizure>>(
          future: allSez,
          builder: (context, snapshot) {
            return RefreshIndicator(
              // ignore: missing_return
              onRefresh: refreshSeizureList,
              child: _listView(snapshot, languageCode, size),
            );
          }),
    );
  }

  Widget _listView(AsyncSnapshot snapshot, String languageCode, Size size) {
    if (snapshot.hasData) {
      if(snapshot.data.length==0)
      {
        return Container(
          width: size.width,
          height: size.height,
          color: kLightColor,
          child: Padding(
              padding: EdgeInsets.all(20),
              child: Text("No data available!",style: TextStyle(fontSize: 18,fontStyle: FontStyle.italic),),),
        );
      } else
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
                      showDialogAndDeleteSez(snapshot.data[index].id, context),
                ),
              ],
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                            SeizureDetails(snapshot.data[index])));
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
                    LineAwesomeIcons.brain,
                    color: kPrimaryColor,
                    size: 35,
                  ),
                  title: Text(
                    DateFormat("MMMM, dd, yyyy", languageCode)
                            .format(snapshot.data[index].date) +
                        "  " +
                        snapshot.data[index].startAt.format(context),
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
                                Icons.access_time,
                                color: kPrimaryLightColor,
                                size: 17,
                              )),
                          Text(
                            snapshot.data[index].duration.inMinutes.toString() +
                                " minutes ",
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          //Wrap(children: <Widget>[
                          Text("mood: ",
                              style: TextStyle(fontSize: 12)),
                          moodStateIcon(snapshot.data[index].mood, size)
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

  Container moodStateIcon(String moodText, Size size) {
    var backColor = Color.fromRGBO(158, 152, 152, 0.6);
    var textColor = Color.fromRGBO(108, 104, 104, 0.8);
    if (moodText == "Good") {
      backColor = Color.fromRGBO(193, 234, 198, 0.6);
      textColor = Color.fromRGBO(42, 120, 78, 0.8);
    }
    if (moodText == "Normal") {
      backColor = Color.fromRGBO(248, 219, 163, 0.6);
      textColor = Color.fromRGBO(227, 174, 68, 8.0);
    }
    if (moodText == "Bad") {
      backColor = Color.fromRGBO(246, 164, 164, 0.6);
      textColor = Color.fromRGBO(252, 89, 89, 0.8);
    }

    if (moodText == "Not Selected") {
      moodText = "No";
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 9),
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Text(
        moodText,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            color: textColor,
            fontSize: 13),
      ),
    );
  }

  Future<void> refreshSeizureList() async {
    if (mounted)
      setState(() {
        allSez = getSeizures(widget.userId);
      });

    await Future.delayed(Duration(seconds: 2));
  }

  showDialogAndDeleteSez(int id, BuildContext context) {
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
      title: Text('Delete Seizure'),
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
            var response = await apiDeleteSeizure(id);
            if (!response) {
              showDialog<void>(
                  context: context, builder: (context) => errorDialog);
              return;
            } else {
              Navigator.of(context).pop();
              refreshSeizureList();
            }
          },
          child: Text('ACCEPT'),
        ),
      ],
    );

    showDialog<void>(context: context, builder: (context) => dialog);
  }
}
