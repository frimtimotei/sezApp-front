import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Seizure {
  String id;
  DateTime date;
  TimeOfDay startAt;
  Duration duration;
  String sezTrigger;
  String activity;
  String type;
  String location;
  String mood;
  String notes;


  Seizure({this.id, this.date, this.startAt, this.duration, this.sezTrigger,
      this.activity, this.type, this.location, this.mood, this.notes});

  Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int seconds=0;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }

  Seizure.fromJson(Map<String, dynamic> json) {
    final format = DateFormat.jm(); //"6:00 AM"

    id = json['id'].toString();
    date = DateTime.parse(json['date']);
    startAt = TimeOfDay.fromDateTime(format.parse(json['start_at']));
    duration = parseDuration(json['duration']);
    type = json['type'];
    sezTrigger= json['sez_trigger'];
    activity= json['activity'].toString();
    location=json['location'];
    mood= json['mood'];
    if(json['note']== null){
      notes="No notes";
    }
    else{
      notes=json['note'];
    }

  }



}



