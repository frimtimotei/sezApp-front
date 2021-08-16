class Reminder{

  String time;
  String howOften;

  Reminder( {this.time, this.howOften});


 Reminder.fromJson(dynamic json){
    time=json['alarmTime'];
    howOften=json['howOften'];}

  }


