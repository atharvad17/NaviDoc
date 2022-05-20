// To parse this JSON data, do
//
//     final SummaryReports = SummaryReportsFromJson(jsonString);

import 'dart:convert';

SummaryReports SummaryReportsFromJson(String str) => SummaryReports.fromJson(json.decode(str));

String SummaryReportsToJson(SummaryReports data) => json.encode(data.toJson());

class SummaryReports {
  SummaryReports({
    required this.SrNo,
    required this.HospitalId,
    required this.HospitalName,
    required this.SurgeryDate,
    required this.AmountBilled,
    required this.AmountReceived,
    required this.PatientName,
    required this.PatientAge,
    required this.SurgeryCategory,
    required this.SurgeryProcedure,
    required this.UserId,
    required this.fromDate,
    required this.toDate,
  });

  int SrNo;
  int HospitalId;
  String HospitalName;
  String SurgeryDate;
  String AmountBilled;
  int AmountReceived;
  String PatientName;
  String PatientAge;
  String SurgeryCategory;
  String SurgeryProcedure;
  int UserId;
  String fromDate;
  String toDate;

  factory SummaryReports.fromJson(Map<String, dynamic> json) => SummaryReports(
    SrNo: json["SrNo"],
    HospitalId: json["HospitalId"],
    HospitalName: json["HospitalName"],
    SurgeryDate: json["SurgeryDate"],
    AmountBilled: json["AmountBilled"],
    AmountReceived: json["AmountReceived"],
    PatientName: json["PatientName"],
    PatientAge: json["PatientAge"],
    SurgeryCategory: json["SurgeryCategory"],
    SurgeryProcedure: json["SurgeryProcedure"],
    UserId: json["UserId"],
    fromDate: json["fromDate"],
    toDate: json["toDate"],
  );

  Map<String, dynamic> toJson() => {
    "SrNo": SrNo,
    "HospitalId": HospitalId,
    "HospitalName": HospitalName,
    "SurgeryDate": SurgeryDate,
    "AmountBilled": AmountBilled,
    "AmountReceived": AmountReceived,
    "PatientName": PatientName,
    "PatientAge": PatientAge,
    "SurgeryCategory": SurgeryCategory,
    "SurgeryProcedure": SurgeryProcedure,
    "UserId": UserId,
    "fromDate": fromDate,
    "toDate": toDate,
  };
}
