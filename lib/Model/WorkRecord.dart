import 'dart:convert';

import 'package:navi_doc/Model/AmountReceived.dart';

WorkRecord workRecordFromJson(String str) => WorkRecord.fromJson(json.decode(str));

String workRecordToJson(WorkRecord data) => json.encode(data.toJson());

class WorkRecord {
  WorkRecord({
    required this.Id,
    required this.UserId,
    required this.HospitalId,
    required this.AdminId,
    required this.SurgeryDate,
    required this.Category,
    required this.CategoryId,
    required this.SurgeryDetail,
    required this.SurgeryProcedure,
    required this.AmountCharged,
    required this.Notes,
    required this.DueDate,
    required this.Status,
    required this.FromTime,
    required this.ToTime,
    required this.PatientName,
    required this.PatientSex,
    required this.PatientAge,
    required this.OutstandingDays,
    required this.CreatedBy,
    required this.CreatedOn,
    required this.UpdatedBy,
    required this.UpdatedOn,
    required this.HospitalName,
    required this.amountReceived,
    required this.AmountReceivedDetails,
  });

  int Id;
  int UserId;
  int HospitalId;
  int AdminId;
  String SurgeryDate;
  String Category;
  int CategoryId;
  String SurgeryDetail;
  String SurgeryProcedure;
  String AmountCharged;
  String Notes;
  String DueDate;
  int Status;
  String FromTime;
  String ToTime;
  String PatientName;
  String PatientSex;
  String PatientAge;
  int OutstandingDays;
  String CreatedBy;
  String CreatedOn;
  String UpdatedBy;
  String UpdatedOn;
  String HospitalName;
  AmountReceived? amountReceived;
  List<dynamic> AmountReceivedDetails;

  factory WorkRecord.fromJson(Map<String, dynamic> json) => WorkRecord(
    Id: json["Id"],
    UserId: json["UserId"],
    HospitalId: json["HospitalId"],
    AdminId: json["AdminId"],
    SurgeryDate: json["SurgeryDate"],
    Category: json["Category"],
    CategoryId: json["CategoryId"],
    SurgeryDetail: json["SurgeryDetail"],
    SurgeryProcedure: json["SurgeryProcedure"],
    AmountCharged: json["AmountCharged"],
    Notes: json["Notes"],
    DueDate: json["DueDate"],
    Status: json["Status"],
    FromTime: json["FromTime"],
    ToTime: json["ToTime"],
    PatientName: json["PatientName"],
    PatientSex: json["PatientSex"],
    PatientAge: json["PatientAge"],
    OutstandingDays: json["OutstandingDays"],
    CreatedBy: json["CreatedBy"],
    CreatedOn: json["CreatedOn"],
    UpdatedBy: json["UpdatedBy"],
    UpdatedOn: json["UpdatedOn"],
    HospitalName: json["HospitalName"],
    amountReceived: AmountReceived.fromJson(json["amountReceived"]),
    AmountReceivedDetails: List<AmountReceived>.from(json["AmountReceivedDetails"].map((x) => AmountReceived.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Id": Id,
    "UserId": UserId,
    "HospitalId": HospitalId,
    "AdminId": AdminId,
    "SurgeryDate": SurgeryDate,
    "Category": Category,
    "CategoryId": CategoryId,
    "SurgeryDetail": SurgeryDetail,
    "SurgeryProcedure": SurgeryProcedure,
    "AmountCharged": AmountCharged,
    "Notes": Notes,
    "DueDate": DueDate,
    "Status": Status,
    "FromTime": FromTime,
    "ToTime": ToTime,
    "PatientName": PatientName,
    "PatientSex": PatientSex,
    "PatientAge": PatientAge,
    "OutstandingDays": OutstandingDays,
    "CreatedBy": CreatedBy,
    "CreatedOn": CreatedOn,
    "UpdatedBy": UpdatedBy,
    "UpdatedOn": UpdatedOn,
    "HospitalName": HospitalName,
    "amountReceived": amountReceived,
    "AmountReceivedDetails": List<dynamic>.from(AmountReceivedDetails.map((x) => x.toJson())),
  };
}