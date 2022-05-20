
// To parse this JSON data, do
//
//     final amountReceived = amountReceivedFromJson(jsonString);

import 'dart:convert';

AmountReceived amountReceivedFromJson(String str) => AmountReceived.fromJson(json.decode(str));

String amountReceivedToJson(AmountReceived data) => json.encode(data.toJson());

class AmountReceived {
  AmountReceived({
    required this.Id,
    required this.WorkrecordId,
    required this.Amount_Received,
    required this.OnDate,
    required this.CreatedBy,
    required this.CreatedOn,
    required this.UpdatedBy,
    required this.UpdatedOn,
  });

  int Id;
  int WorkrecordId;
  String Amount_Received;
  String OnDate;
  String CreatedBy;
  String CreatedOn;
  String UpdatedBy;
  String UpdatedOn;

  factory AmountReceived.fromJson(Map<String, dynamic> json) {
    if(json != null)
   return AmountReceived(
      Id: json["Id"],
      WorkrecordId: json["WorkrecordId"],
      Amount_Received: json["Amount_Received"],
      OnDate: json["OnDate"],
      CreatedBy: json["CreatedBy"],
      CreatedOn: json["CreatedOn"],
      UpdatedBy: json["UpdatedBy"],
      UpdatedOn: json["UpdatedOn"],
    );
    else{
      return AmountReceived(
          Id: 0,WorkrecordId: 0,Amount_Received: "",OnDate: "",CreatedBy: "",CreatedOn: "",UpdatedBy: "",UpdatedOn: ""
      );
    }
  }

  Map<String, dynamic> toJson() => {
    "Id": Id,
    "WorkrecordId": WorkrecordId,
    "Amount_Received": Amount_Received,
    "OnDate": OnDate,
    "CreatedBy": CreatedBy,
    "CreatedOn": CreatedOn,
    "UpdatedBy": UpdatedBy,
    "UpdatedOn": UpdatedOn,
  };
}
