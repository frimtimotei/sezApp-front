class RegisterResponseModel {}

class RegisterRequestModel {
  String firstName;
  String lastName;
  String email;
  String password;
  String sex;
  int age;
  String role;
  String imageUrl;

  RegisterRequestModel({this.firstName, this.lastName, this.email, this.password,
      this.sex, this.age, this.role, this.imageUrl});
}
