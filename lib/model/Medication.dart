
import 'package:sezapp/model/reminder_model.dart';

class Medication{
int id;
String name;
String dose;
String startDate;
String endDate;
List <Reminder> reminders;

Medication({this.id, this.name, this.dose, this.startDate, this.endDate,
      this.reminders});
}