class MedicationReminder{
  String medicationId;
  String name;
  String startDate;
  String endDate;
  String alarmTime;
  String howOften;
  String dose;

  MedicationReminder({this.medicationId, this.name, this.startDate, this.endDate,
      this.alarmTime, this.howOften, this.dose});

  MedicationReminder.fromJson(Map<String, dynamic> json) {
    medicationId = json['medicationId'];
    name = json['name'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    alarmTime = json['alarmTime'];
    howOften = json['howOften'];
    dose=json["dose"];
  }
}