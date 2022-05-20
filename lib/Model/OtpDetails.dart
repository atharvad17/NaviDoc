// To parse this JSON data, do
//
//     final otpDetails = otpDetailsFromJson(jsonString);

import 'dart:convert';

OtpDetails otpDetailsFromJson(String str) => OtpDetails.fromJson(json.decode(str));

String otpDetailsToJson(OtpDetails data) => json.encode(data.toJson());

class OtpDetails {
  // OtpDetails({this.OtpId,
  //   required this.UserId,
  //   required this.EmailId,
  //   required this.MobileNo,
  //   required this.Otp,
  //   required this.IfOtpUsed,
  //   required this.CreatedBy,
  //   required this.CreatedOn,
  //   required this.UpdatedBy,
  //   required this.UpdatedOn,
  //   required this.AdminId
  // });

  OtpDetails({
    required this.OtpId,
    required this.UserId,
    required this.EmailId,
    required this.MobileNo,
    required this.Otp,
    required this.IfOtpUsed,
    required this.UserName,
    required this.CreatedBy,
    required this.CreatedOn,
    required this.UpdatedBy,
    required this.UpdatedOn,
    required this.AdminId
  });

  int OtpId;
  int UserId;
  String EmailId;
  String MobileNo;
  String Otp;
  int IfOtpUsed;
  String CreatedBy;
  String CreatedOn;
  String UpdatedBy;
  String UpdatedOn;
  int AdminId;
  String UserName;

  factory OtpDetails.fromJson(Map<String, dynamic> json) => OtpDetails(
    OtpId: json["OtpId"],
    UserId: json["UserId"],
    EmailId: json["EmailId"],
    MobileNo: json["MobileNo"],
    Otp: json["Otp"],
    IfOtpUsed: json["IfOtpUsed"],
    UserName: json['UserName'],
    CreatedBy: json["CreatedBy"],
    CreatedOn: json["CreatedOn"],
    UpdatedBy: json["UpdatedBy"],
    UpdatedOn: json["UpdatedOn"],
    AdminId: json["AdminId"],
  );

  Map<String, dynamic> toJson() => {
    "OtpId": OtpId,
    "UserId": UserId,
    "EmailId": EmailId,
    "MobileNo": MobileNo,
    "Otp": Otp,
    "IfOtpUsed": IfOtpUsed,
    "UserName": UserName,
    "CreatedBy": CreatedBy,
    "CreatedOn": CreatedOn,
    "UpdatedBy": UpdatedBy,
    "UpdatedOn": UpdatedOn,
    "AdminId": AdminId,
  };
}
