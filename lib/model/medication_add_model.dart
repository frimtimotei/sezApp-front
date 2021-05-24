import 'package:sezapp/model/reminder_model.dart';

class MedicationRegisterModel{

  int id;
  String name;
  String dose;
  String startDate;
  String endDate;
  bool setReminder;


  MedicationRegisterModel({this.id, this.name, this.dose, this.startDate,
      this.endDate, this.setReminder});
}