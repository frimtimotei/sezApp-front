class Doctor {
  String id;
  String email;
  String firstName;
  String lastName;
  String age;
  String imageUrl;
  String sex;

  Doctor({this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.age,
    this.imageUrl,
    this.sex});


  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    age = json['age'];
    imageUrl = json['imageUrl'];
    sex = json['sex'];
  }
}