// To parse this JSON data, do
//
//     final procedureDetails = procedureDetailsFromJson(jsonString);

import 'dart:convert';

ProcedureDetails procedureDetailsFromJson(String str) => ProcedureDetails.fromJson(json.decode(str));

String procedureDetailsToJson(ProcedureDetails data) => json.encode(data.toJson());

class ProcedureDetails {
  ProcedureDetails({
    required this.Id,
    required this.AdminId,
    required this.CategoryId,
    required this.ProcedureName,
    required this.Active,
    required this.CreatedBy,
    required this.CreatedOn,
    required this.UpdatedBy,
    required this.UpdatedOn,
  });

  int Id;
  int AdminId;
  int CategoryId;
  String ProcedureName;
  int Active;
  String CreatedBy;
  String CreatedOn;
  String UpdatedBy;
  String UpdatedOn;

  factory ProcedureDetails.fromJson(Map<String, dynamic> json) => ProcedureDetails(
    Id: json["Id"],
    AdminId: json["AdminId"],
    CategoryId: json["CategoryId"],
    ProcedureName: json["ProcedureName"],
    Active: json["Active"],
    CreatedBy: json["CreatedBy"],
    CreatedOn: json["CreatedOn"],
    UpdatedBy: json["UpdatedBy"],
    UpdatedOn: json["UpdatedOn"],
  );

  Map<String, dynamic> toJson() => {
    "Id": Id,
    "AdminId": AdminId,
    "CategoryId": CategoryId,
    "ProcedureName": ProcedureName,
    "Active": Active,
    "CreatedBy": CreatedBy,
    "CreatedOn": CreatedOn,
    "UpdatedBy": UpdatedBy,
    "UpdatedOn": UpdatedOn,
  };
}
