class Patient {
  String id;
  String email;
  String firstName;
  String lastName;
  String age;
  String imageUrl;
  String sex;

  Patient({this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.age,
    this.imageUrl,
  this.sex});


  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    age = json['age'];
    imageUrl = json['imageUrl'];
    sex = json['sex'];

  }
}