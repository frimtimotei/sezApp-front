import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:sezapp/api/seizureApiService.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:sezapp/components/customAppBar.dart';
import 'package:sezapp/components/buttonFullWidget.dart';
import 'package:sezapp/components/whiteIconButton.dart';
import 'package:sezapp/constants.dart';
import 'package:sezapp/model/SeizureRegisterModel.dart';
import 'package:cool_alert/cool_alert.dart';

class AddSeizurePage extends StatefulWidget {
  @override
  _AddSeizurePageState createState() => _AddSeizurePageState();
}

class SezAndTrigg {
  final int id;
  final String name;

  SezAndTrigg({
    this.id,
    this.name,
  });
}

DateTime now = new DateTime.now();
SeizureRegisterModel seizureRequestModel = new SeizureRegisterModel();

class _AddSeizurePageState extends State<AddSeizurePage> {
  DateTime _date = DateTime(now.year, now.month, now.day);
  TimeOfDay _starAt;
  Duration _duration = Duration(hours: 0, minutes: 0, seconds: 00);

  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  String moodDropdown = "Not Selected";
  String locationDropdown = "Home";

  final noteController = TextEditingController();

  String errorMessage = "";

  void _selectDate() async {
    final DateTime newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2017, 1),
      lastDate: _date,
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
      });
    }
  }

  void _selectStartTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _starAt,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        _starAt = newTime;
      });
    }
  }

  void _selectDuration() async {
    var resultingDuration = await showDurationPicker(
      context: context,
      initialTime: _duration,
    );
    if (resultingDuration != null) {
      setState(() {
        _duration = resultingDuration;
      });
    }
  }

  static List<SezAndTrigg> _possibleTriggers = [
    SezAndTrigg(id: 1, name: "Alcohol Consumption"),
    SezAndTrigg(id: 2, name: "Illicit Drug Use"),
    SezAndTrigg(id: 3, name: "Fever"),
    SezAndTrigg(id: 4, name: "Flashing Lights"),
    SezAndTrigg(id: 5, name: "High Ketones"),
    SezAndTrigg(id: 6, name: "Hormonal Fluctuations"),
    SezAndTrigg(id: 7, name: "Hyperthermia"),
    SezAndTrigg(id: 8, name: "Illness"),
    SezAndTrigg(id: 9, name: "Low Ketones"),
    SezAndTrigg(id: 10, name: "Medication Change"),
    SezAndTrigg(id: 11, name: "Missed Dose"),
    SezAndTrigg(id: 12, name: "Sleep Deprivation"),
    SezAndTrigg(id: 13, name: "Stress"),
    SezAndTrigg(id: 14, name: "Other"),
  ];

  static List<SezAndTrigg> _possibleSeizures = [
    SezAndTrigg(id: 1, name: "Absence"),
    SezAndTrigg(id: 2, name: "Atonic"),
    SezAndTrigg(id: 3, name: "Atypical Absence"),
    SezAndTrigg(id: 4, name: "Aura Only"),
    SezAndTrigg(id: 5, name: "Colnic"),
    SezAndTrigg(id: 6, name: "Complex Partial"),
    SezAndTrigg(id: 7, name: "Myoclonic"),
    SezAndTrigg(id: 8, name: "Myoclonic Clausters"),
    SezAndTrigg(id: 9, name: "Gelastic"),
    SezAndTrigg(id: 10, name: "Infantile Spasm"),
    SezAndTrigg(id: 11, name: "Secondarily Generalized"),
    SezAndTrigg(id: 12, name: "Simple Partial"),
    SezAndTrigg(id: 13, name: "Tonic"),
    SezAndTrigg(id: 14, name: "Tonic-Clonic"),
    SezAndTrigg(id: 15, name: "Other"),
  ];

  static List<SezAndTrigg> _possibleActivities = [
    SezAndTrigg(id: 1, name: "Falling Asleep"),
    SezAndTrigg(id: 2, name: "Sleeping"),
    SezAndTrigg(id: 3, name: "Waking Up"),
    SezAndTrigg(id: 4, name: "Studying"),
    SezAndTrigg(id: 5, name: "Working"),
    SezAndTrigg(id: 6, name: "Exercising"),
    SezAndTrigg(id: 7, name: "Watching TV"),
    SezAndTrigg(id: 8, name: "Phone"),
    SezAndTrigg(id: 9, name: "Other"),
  ];

  List _possibleLocations = [
    "Home",
    "School",
    "Work",
    "Gym",
    "Outdoors",
    "Others"
  ];

  List _possibleMoods = ["Not Selected", "Normal", "Good", "Bad"];

  List<SezAndTrigg> _selectedTriggers = [];
  List<SezAndTrigg> _selectedSeizures = [];
  List<SezAndTrigg> _selectedActivities = [];

  final _triggerItems = _possibleTriggers
      .map((trigger) => MultiSelectItem<SezAndTrigg>(trigger, trigger.name))
      .toList();
  final _seizureItems = _possibleSeizures
      .map((seizure) => MultiSelectItem<SezAndTrigg>(seizure, seizure.name))
      .toList();

  final _activityItems = _possibleActivities
      .map((activity) => MultiSelectItem<SezAndTrigg>(activity, activity.name))
      .toList();

  @override
  void initState() {
    _starAt = TimeOfDay(hour: now.hour, minute: now.minute);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: CustomAppBar(
            title: "Add Seizure",
          )),
      body: Container(
        color: kLightColor,
        height: size.height,
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: 320,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  WhiteIconButton(
                    height: 50,
                    width: 320,
                    icon: Icon(
                      LineAwesomeIcons.calendar,
                      size: 43,
                      color: kPrimaryColor,
                    ),
                    text: Text(
                      DateFormat.yMMMMd('en_US').format(_date),
                      style: TextStyle(color: kPrimaryColor),
                    ),
                    callback: _selectDate,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Start at:",
                            style: TextStyle(color: kPrimaryColor),
                          ),
                          WhiteIconButton(
                              height: 50,
                              width: 150,
                              icon: Icon(LineAwesomeIcons.clock,
                                  size: 43, color: kPrimaryColor),
                              text: Text(
                                '${_starAt.format(context)}',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: kPrimaryColor),
                              ),
                              callback: _selectStartTime),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Duration: ",
                            style: TextStyle(color: kPrimaryColor),
                          ),
                          WhiteIconButton(
                              height: 50,
                              width: 150,
                              callback: _selectDuration,
                              icon: Icon(LineAwesomeIcons.clock,
                                  size: 43, color: kPrimaryColor),
                              text: Text(
                                '${format(_duration)}',
                                style: TextStyle(
                                  color: kPrimaryColor,
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //////////////////////////////////////////////////////
                  ////// Add possible Trigger
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        MultiSelectDialogField(
                          items: _triggerItems,
                          title: Text("Add Possible Trigger"),
                          selectedColor: Color.fromRGBO(245, 115, 115, 1.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, 0.08),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 15))
                            ],
                          ),
                          buttonIcon: Icon(LineAwesomeIcons.flag,
                              size: 33, color: kPrimaryColor),
                          buttonText: Text(
                            "Add Possible Trigger",
                            style: TextStyle(
                              color: kPrimaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onConfirm: (results) {
                            _selectedTriggers = results;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //////////////////////////////////////////////////////////////
                  //Add Seizure Type Area
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        MultiSelectDialogField(
                          items: _seizureItems,
                          title: Text("Seizure Type"),
                          selectedColor: Color.fromRGBO(122, 191, 154, 1),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, 0.08),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 15))
                            ],
                          ),
                          buttonIcon: Icon(LineAwesomeIcons.brain,
                              size: 33, color: kPrimaryColor),
                          buttonText: Text(
                            "Add Seizure Type",
                            style: TextStyle(
                              color: kPrimaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onConfirm: (results) {
                            _selectedSeizures = results;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //////////////////////////////////////////////////////////////
                  ////Add activity
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        MultiSelectDialogField(
                          items: _activityItems,
                          title: Text("Activity"),
                          selectedColor: Color.fromRGBO(232, 181, 70, 1),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, 0.08),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 15))
                              ]),
                          buttonIcon: Icon(LineAwesomeIcons.walking,
                              size: 33, color: kPrimaryColor),
                          buttonText: Text(
                            "Add Activity",
                            style: TextStyle(
                              color: kPrimaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onConfirm: (results) {
                            _selectedActivities = results;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //////////////////////////////////////////////////////////////
                  /// Add Mood

                  Text(
                    "Mood",
                    style: TextStyle(color: kPrimaryColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, 0.08),
                              blurRadius: 20.0,
                              offset: Offset(0, 15))
                        ]),
                    width: 320,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: DropdownButton(
                            isExpanded: true,
                            value: moodDropdown,
                            underline: SizedBox(),
                            items: _possibleMoods.map((value) {
                              return DropdownMenuItem<String>(
                                  value: value, child: Text(value));
                            }).toList(),
                            onChanged: (String newValue) {
                              setState(() {
                                moodDropdown = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  //////////////////////////////////////////////////////////////
                  ////Add location
                  Column(
                    children: [
                      Text(
                        "Add Location",
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, 0.08),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 15))
                            ]),
                        width: 320,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: DropdownButton(
                                isExpanded: true,
                                value: locationDropdown,
                                underline: SizedBox(),
                                items: _possibleLocations.map((value) {
                                  return DropdownMenuItem<String>(
                                      value: value, child: Text(value));
                                }).toList(),
                                onChanged: (String newValue) {
                                  setState(() {
                                    locationDropdown = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      //////////////////////////////////////////////////////////
                      //// Other notes
                      Column(
                        children: [
                          Text(
                            "Add Other Notes",
                            style: TextStyle(color: kPrimaryColor),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          Color.fromRGBO(143, 148, 251, 0.08),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 15))
                                ]),
                            child: Column(children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 8),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Other Notes',
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                  controller: noteController,
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            errorMessage,
                            style: TextStyle(color: Colors.red),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      ButtonFullWidget(
                          name: "Save",
                          callback: _seizureSubmit,
                          width: 320,
                          height: 50),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _seizureSubmit() async {
    String sezTriggers;
    String seizuresType;
    String activities;
    // check if all fields are completed
    if (_duration.inSeconds == 0) {
      setState(() {
        errorMessage = "Duration must be grater then 0:00";
      });
      return;
    }

    setState(() {
      errorMessage = "";
    });

    /// data for api format
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(_date);
    if (_selectedTriggers.isNotEmpty) {
      sezTriggers = _selectedTriggers
          .map((product) => product.name)
          .reduce((value, element) => value + "," + element);
    } else
      sezTriggers = "No Trigger Added";

    if (_selectedSeizures.isNotEmpty) {
      seizuresType = _selectedSeizures
          .map((product) => product.name)
          .reduce((value, element) => value + "," + element);
    } else
      seizuresType = "No Seizure Type Added";

    if (_selectedActivities.isNotEmpty) {
      activities = _selectedActivities
          .map((product) => product.name)
          .reduce((value, element) => value + "," + element);
    } else
      activities = "No Activities Added";

    seizureRequestModel.date = formattedDate;
    seizureRequestModel.startAt = _starAt.format(context);
    seizureRequestModel.duration = format(_duration);
    seizureRequestModel.sezTrigger = sezTriggers;
    seizureRequestModel.type = seizuresType;
    seizureRequestModel.activity = activities;
    seizureRequestModel.location = locationDropdown;
    seizureRequestModel.mood = moodDropdown;
    seizureRequestModel.notes = noteController.text;

    var response = await seizureRegister(seizureRequestModel);
    print(response);

    if (response['id'] != null) {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          confirmBtnColor: kPrimaryColor,
          text: "Your seizure has been saved!",
          backgroundColor: kPrimaryColor,
          onConfirmBtnTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
          });
    } else {
      setState(() {
        errorMessage = "error";
      });
    }
  }
}
