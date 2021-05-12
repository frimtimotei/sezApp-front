class LoginResponseModel{

}

class LoginRequestModel{
  String emil;
  String password;

  LoginRequestModel({
   this.emil,
   this.password,
});

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map={
      'email':emil.trim(),
      'password': password.trim()
    };
    return map;
  }

}