import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sezapp/Screens/Patient/Reports/seziuresActions.dart';
import 'package:sezapp/api/seizure_api_service.dart';
import 'package:sezapp/constants.dart';
import 'package:sezapp/model/Seizure.dart';
import 'package:intl/date_symbol_data_local.dart';

class AllSeizures extends StatefulWidget {
  const AllSeizures({Key key}) : super(key: key);

  @override
  _AllSeizuresState createState() => _AllSeizuresState();
}

class _AllSeizuresState extends State<AllSeizures> {
  Future<List<Seizure>> allSez;

  @override
  void initState() {
    super.initState();
    allSez = getSeizures();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    String languageCode = Localizations.localeOf(context).languageCode;
    return Container(
      color: kLightColor,
      child: FutureBuilder<List<Seizure>>(
          future: allSez,
          builder: (context, snapshot) {
            return RefreshIndicator(
              // ignore: missing_return
              onRefresh: () async {
                if (mounted)
                  setState(() {
                    allSez = getSeizures();
                  });

                await Future.delayed(Duration(seconds: 2));
              },
              child: _listView(snapshot, languageCode),
            );
          }),
    );
  }

  Widget _listView(AsyncSnapshot snapshot, String languageCode) {
    if (snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.transparent,
            elevation: 0,
            margin: new EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.8),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(143, 148, 251, 0.05),
                        blurRadius: 50.0,
                        offset: Offset(0, 6))
                  ]),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                leading:

                  Icon(LineAwesomeIcons.brain, color: kPrimaryColor, size: 35,),

                title: Text(DateFormat("MMMM, dd, yyyy", languageCode)
                        .format(snapshot.data[index].date) +
                    "  " +
                    snapshot.data[index].startAt.format(context)),
                subtitle: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                            child: Icon(
                          Icons.access_time,
                          color: Colors.red,
                          size: 17,
                        )),
                        Text(
                            snapshot.data[index].duration.inMinutes.toString() +
                                " minutes "),

                      ],
                    ),
                  ],
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
}
