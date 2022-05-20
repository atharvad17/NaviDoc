
import 'package:navi_doc/Model/UserLogin.dart';
import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo{
  late int Id;
  late String Name, Surname, Speciality, Degree, MobileNo, Address, State, District,
      City, PinCode, Email_id, Date_of_birth, CreatedBy, CreatedOn, UpdatedBy, UpdatedOn;
  late UserLogin userLogin;


  UserInfo({required this.Id, required this.Name, required this.Surname, required this.Speciality, required this.Degree, required this.MobileNo, required this.Address,
      required this.District, required this.City, required this.State, required this.PinCode, required this.Email_id, required this.Date_of_birth, required this.userLogin});


  Map<String, dynamic> toJson() => {
    "Id": Id,
    "Name": Name,
    "Surname": Surname,
    "Speciality": Speciality,
    "Degree": Degree,
    "MobileNo": MobileNo,
    "Address": Address,
    "District": District,
    "City": City,
    "State": State,
    "PinCode": PinCode,
    "Email_id": Email_id,
    "Date_of_birth": Date_of_birth,
    "userLogin": userLogin,
  };

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    Id: json["Id"],
    Name: json["Name"],
    Surname: json["Surname"],
    Speciality: json["Speciality"],
    Degree: json["Degree"],
    MobileNo: json["MobileNo"],
    Address: json["Address"],
    District: json["District"],
    City: json["City"],
    State: json["State"],
    PinCode: json["PinCode"],
    Email_id: json["Email_id"],
    Date_of_birth: json["Date_of_birth"],
    userLogin: UserLogin.fromJson(json["userLogin"]),
  );
}

