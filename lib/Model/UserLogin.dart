
// To parse this JSON data, do
//
//     final userLogin = userLoginFromJson(jsonString);

import 'dart:convert';

UserLogin userLoginFromJson(String str) => UserLogin.fromJson(json.decode(str));

String userLoginToJson(UserLogin data) => json.encode(data.toJson());

class UserLogin {
  UserLogin({required this.Id, required this.Userinfo_id, required this.Username, required this.Password, required this.Token,
      required this.Status});

  int Id, Userinfo_id, Status;
  String Username, Password, Token;

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
    Id: json["Id"],
    Userinfo_id: json["Userinfo_id"],
    Username: json["Username"],
    Password: json["Password"],
    Token: json["Token"],
    Status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "Id": Id,
    "Userinfo_id": Userinfo_id,
    "Username": Username,
    "Password": Password,
    "Token": Token,
    "Status": Status,
  };


}



