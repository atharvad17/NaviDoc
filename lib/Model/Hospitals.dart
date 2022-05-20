
// To parse this JSON data, do
//
//     final hospitals = hospitalsFromJson(jsonString);

import 'dart:convert';

Hospitals hospitalsFromJson(String str) => Hospitals.fromJson(json.decode(str));

String hospitalsToJson(Hospitals data) => json.encode(data.toJson());

class Hospitals {
  Hospitals({
    required this.Id,
    required this.Name,
    required this.Address,
    required this.District,
    required this.Citys,
    required this.State,
    required this.Department,
    required this.Contact_person,
    required this.Mobile_of_contact,
    required this.Payment_day,
    required this.PinCode,
    required this.AdminId,
    required this.CreatedBy,
    required this.CreatedOn,
    required this.UpdatedBy,
    required this.UpdatedOn,
  });

  int Id;
  String Name;
  String Address;
  String District;
  String Citys;
  String State;
  String Department;
  String Contact_person;
  String Mobile_of_contact;
  String Payment_day;
  String PinCode;
  int AdminId;
  String CreatedBy;
  String CreatedOn;
  String UpdatedBy;
  String UpdatedOn;

  factory Hospitals.fromJson(Map<String, dynamic> json) => Hospitals(
    Id: json["Id"],
    Name: json["Name"],
    Address: json["Address"],
    District: json["District"],
    Citys: json["Citys"],
    State: json["State"],
    Department: json["Department"],
    Contact_person: json["Contact_person"],
    Mobile_of_contact: json["Mobile_of_contact"],
    Payment_day: json["Payment_day"],
    PinCode: json["PinCode"],
    AdminId: json["AdminId"],
    CreatedBy: json["CreatedBy"],
    CreatedOn: json["CreatedOn"],
    UpdatedBy: json["UpdatedBy"],
    UpdatedOn: json["UpdatedOn"],
  );

  Map<String, dynamic> toJson() => {
    "Id": Id,
    "Name": Name,
    "Address": Address,
    "District": District,
    "Citys": Citys,
    "State": State,
    "Department": Department,
    "Contact_person": Contact_person,
    "Mobile_of_contact": Mobile_of_contact,
    "Payment_day": Payment_day,
    "PinCode": PinCode,
    "AdminId": AdminId,
    "CreatedBy": CreatedBy,
    "CreatedOn": CreatedOn,
    "UpdatedBy": UpdatedBy,
    "UpdatedOn": UpdatedOn,
  };
}
