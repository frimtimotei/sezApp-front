import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sezapp/api/medication_api_service.dart';
import 'package:sezapp/components/customAppBar.dart';
import 'package:sezapp/components/buttonFullWidget.dart';
import 'package:sezapp/components/customInputField.dart';
import 'package:sezapp/components/whiteIconButton.dart';
import 'package:sezapp/model/MedicationRegisterModel.dart';
import 'package:sezapp/model/Reminder.dart';

import '../../../constants.dart';

class AddMedicationPage extends StatefulWidget {
  final userId;
  final userName;
  final doctorName;


  AddMedicationPage({Key key, this.userId, this.doctorName, this.userName}) : super(key: key);

  @override
  _AddMedicationPageState createState() => _AddMedicationPageState();
}

DateTime now = new DateTime.now();
TextEditingController nameController = new TextEditingController();
TextEditingController doseController = new TextEditingController();
DateTime _startDate = DateTime(now.year, now.month, now.day);
DateTime _lastDate = DateTime(now.year + 5);
DateTime _endDate = DateTime(now.year, now.month, now.day + 4);

TimeOfDay newTimeSet;
List<Widget> chipsTimeList;
TimeOfDay _initialTime = TimeOfDay(hour: 9, minute: 00);


String message = "";

GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>(); //form key


format(Duration d) =>
    d
        .toString()
        .split('.')
        .first
        .padLeft(8, "0");

List _howOften = [
  "Every Day",
  "Every Second Day",
  "Weekly",
];
String oftenDropdown = "Every Day";

class _AddMedicationPageState extends State<AddMedicationPage> {
  List<TimeOfDay> remindersTimes;

  @override
  void initState() {
    chipsTimeList = [];
    remindersTimes = [];
    message = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    void _selectDate() async {
      final DateTime newDate = await showDatePicker(
        context: context,
        initialDate: _startDate,
        firstDate: DateTime(2017, 1),
        helpText: 'Select a date',
        lastDate: _lastDate,
      );
      if (newDate != null) {
        setState(() {
          _startDate = newDate;
        });
      }
    }

    void _selectEndDate() async {
      final DateTime endDatePik = await showDatePicker(
        context: context,
        initialDate: _endDate,
        firstDate: DateTime(2017, 1),
        helpText: 'Select a date',
        lastDate: _lastDate,
      );
      if (endDatePik != null) {
        setState(() {
          _endDate = endDatePik;
        });
      }
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: CustomAppBar(
          title: "Add Medication",
        ),
      ),
      body: Container(
        color: kLightColor,
        height: size.height,
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: 320,
              child: Form(
                key: globalFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                    ),

                    ////////////////////////////////////////////////////////////
                    ///Add Name
                    Column(
                      children: [
                        Text(
                          "Add Medication Name",
                          style: TextStyle(color: kPrimaryColor),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomInputFiled(
                            hintText: "Name...",
                            obscuredText: false,
                            controller: nameController,
                            validator: emptyValidator),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),

                    /////////////////////////////////////////////////////////
                    //Add Dose
                    Column(
                      children: [
                        Text(
                          "Add Dose",
                          style: TextStyle(color: kPrimaryColor),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomInputFiled(
                            hintText: "(i.e. 20 mg)",
                            obscuredText: false,
                            controller: doseController,
                            validator: emptyValidator),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),

                    ///////////////////////////////////////////////////////////
                    ///Add Start Date

                    Column(
                      children: [
                        Text(
                          "Start date:",
                          style: TextStyle(color: kPrimaryColor),
                        ),
                        WhiteIconButton(
                          height: 55,
                          width: 320,
                          icon: Icon(
                            LineAwesomeIcons.calendar,
                            size: 43,
                            color: kPrimaryColor,
                          ),
                          text: Text(
                            DateFormat.yMMMMd('en_US').format(_startDate),
                            style: TextStyle(color: kPrimaryColor),
                          ),
                          callback: _selectDate,
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 25,
                    ),
                    //////////////////////////////////////////////////////////////
                    /////End Date

                    Column(
                      children: [
                        Text(
                          "End date:",
                          style: TextStyle(color: kPrimaryColor),
                        ),
                        WhiteIconButton(
                          height: 55,
                          width: 320,
                          icon: Icon(
                            LineAwesomeIcons.calendar,
                            size: 43,
                            color: kPrimaryColor,
                          ),
                          text: Text(
                            DateFormat.yMMMMd('en_US').format(_endDate),
                            style: TextStyle(color: kPrimaryColor),
                          ),
                          callback: _selectEndDate,
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 25,
                    ),

                    ////////////////////////////////////////////////////////////
                    ///How Often
                    ///
                    Column(
                      children: [
                        Text(
                          "How Often",
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
                                  value: oftenDropdown,
                                  underline: SizedBox(),
                                  items: _howOften.map((value) {
                                    return DropdownMenuItem<String>(
                                        value: value, child: Text(value));
                                  }).toList(),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      oftenDropdown = newValue;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    /////
                    ////////////////////////////////////////////////////////////
                    //////Add Reminder

                    Column(children: [
                      Text(
                        "Reminders",
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      OutlinedButton.icon(
                          icon: Icon(
                            Icons.add,
                            size: 17,
                          ),
                          label: Text("New reminder", style: TextStyle(
                              fontSize: 17),),
                          style: OutlinedButton.styleFrom(
                            primary: kPrimaryColor,
                            padding: EdgeInsets.symmetric(horizontal: 14,
                                vertical: 12),
                            side: BorderSide(
                              width: 1.5,
                              color: kPrimaryColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),

                            ),
                          ),
                          onPressed: () async {
                            final TimeOfDay newTime = await showTimePicker(
                              context: context,
                              initialTime: _initialTime,
                              initialEntryMode: TimePickerEntryMode.input,
                            );
                            if (newTime != null) {
                              setState(() {
                                _initialTime = newTime;
                                remindersTimes.add(_initialTime);
                              });
                            }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 320,
                        child: Wrap(
                          spacing: 6.0,
                          runSpacing: 6.0,
                          children: List.generate(
                              remindersTimes.length, (index) {
                            return RawChip(
                              avatar:
                              Container(
                                child: Icon(
                                    FontAwesomeIcons.bell,
                                    color: kGreenTextColor


                                ),
                              ),
                              labelPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 2),
                              backgroundColor: kGreenBackColor,
                              label: Text(
                                remindersTimes[index].format(context),
                                style: TextStyle(
                                    fontSize: 18, color: kGreenTextColor),
                              ),

                              deleteIconColor: Color.fromRGBO(
                                  66, 60, 60, 0.7),
                              onDeleted: () {
                                setState(() {
                                  remindersTimes.removeAt(index);
                                });
                              },
                            );
                          }),
                        ),
                      ),
                    ],),

                    SizedBox(height: 20,),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          message,
                          style: TextStyle(color: Colors.red),
                        )),
                    SizedBox(
                      height: 10,
                    ),

                    ButtonFullWidget(name: "Add Medication",
                        callback: () {
                          _medicationSubmit(widget.userId);
                        },
                        width: 320,
                        height: 50),

                    SizedBox(height: 50,),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Function emptyValidator = (value) {
    if (value.isEmpty) {
      return 'cannot be empty';
    }

    return null;
  };


  void _medicationSubmit(userId) async {
    message = "";

    if (!globalFormKey.currentState.validate()) {
      setState(() {
        message = "Please fix the errors in red before submitting.";
      });
    } else {
      var formatter = new DateFormat('yyyy-MM-dd');
      MedicationRegisterModel medicationRegisterModel = new MedicationRegisterModel();
      List <Reminder> reminders = [];
      medicationRegisterModel.name = nameController.text;
      medicationRegisterModel.dose = doseController.text;
      medicationRegisterModel.startDate = formatter.format(_startDate);
      medicationRegisterModel.endDate = formatter.format(_endDate);
      medicationRegisterModel.howOften = oftenDropdown;
      if (remindersTimes.isEmpty) {
        medicationRegisterModel.setReminder = false;
      }
      else {
        medicationRegisterModel.setReminder = true;
      }

      for (int i = 0; i < remindersTimes.length; i++) {
        final Reminder reminder = new Reminder();

        reminder.time = remindersTimes[i].format(context);
        reminder.howOften = oftenDropdown;
        reminders.add(reminder);
      }

      /// response from  api
      var response = await medicationRegister(
          medicationRegisterModel, reminders, userId,widget.userName,widget.doctorName);

      print(widget.userName);

      if (response['id'] != null) {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            confirmBtnColor: kPrimaryColor,
            text: "Your medication has been saved!",
            backgroundColor: kPrimaryColor,
            onConfirmBtnTap: () {
              Navigator.pop(context);
              nameController.text = "";
              doseController.text = "";
              remindersTimes = [];
            });
      } else {
        setState(() {
          message = "error";
        });
      }
    }
  }
}
