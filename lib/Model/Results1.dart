
import 'dart:convert';

class Results1 {
  late var Result; //array of objects
  late String error;
  late bool success, HasMore;
  late int TotalResults;

  Results1({required this.error,required this.success, required this.Result, required this.HasMore, required this.TotalResults});

  String userLoginToJson(Results1 data) => json.encode(data.toJson());

  // factory Results1.fromJson(dynamic json) {
  //   return Results1(json['error'] as String,
  //       json['success'] as bool,json['Result'] as bool );
  // }

  factory Results1.fromJson(Map<String, dynamic> json) => Results1(
    Result: json["Result"],
    error: json["error"],
    success: json["success"],
    HasMore: json["HasMore"],
    TotalResults: json["TotalResults"],
  );

  Map<String, dynamic> toJson() => {
    "Result": Result,
    "error": error,
    "success": success,
    "HasMore": HasMore,
    "TotalResults": TotalResults,
  };
}

