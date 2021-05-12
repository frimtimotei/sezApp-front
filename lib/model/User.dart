class User{

  String id;
  String firstName;
  String lastName;
  String email;
  String age;
  String sex;
  String roleId;

  User({this.id, this.firstName, this.lastName, this.email, this.age,
      this.sex});



  User.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    email = json['email'];
    sex= json['sex'];
    age= json['age'].toString();
    roleId=json['roles'][0]['id'].toString();

  }
}