
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sezapp/model/Reminder.dart';

class Medication{
int id;
String name;
String dose;
DateTime startDate;
DateTime endDate;
bool setReminder;
String howOften;
List<Reminder> reminders= [];


Medication({this.id, this.name, this.dose, this.startDate, this.endDate,
      this.setReminder, this.howOften, this.reminders});

  Medication.fromJson(Map<String, dynamic> json) {
  final format = DateFormat.jm(); //"6:00 AM"

  id = json['id'];
  name=json['name'];
  dose=json['dose_gram'];
  startDate = DateTime.parse(json['start_date']);
  endDate = DateTime.parse(json['end_date']);
  setReminder=json['set_reminder'];
  howOften=json['howOften'];
  var remindersFrJson= json['reminders'] as List;
  reminders=remindersFrJson.map((reminder) => Reminder.fromJson(reminder)).toList();

}
}