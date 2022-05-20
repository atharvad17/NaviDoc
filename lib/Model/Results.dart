
import 'dart:convert';

class Results {
  late List<dynamic> Result = []; //array of objects
  late String error;
  late bool success, HasMore;
  late int TotalResults;

  Results(this.error, this.TotalResults,this.success,this.HasMore,this.Result);

  String userLoginToJson(Results data) => json.encode(data.toJson());

  factory Results.fromJson(dynamic json) {
    return Results(json['error'] as String, json['TotalResults'] as int ,
        json['success'] as bool,json['HasMore'] as bool,json['Result'] as List<dynamic> );
  }

  Map<String, dynamic> toJson() => {
    "Result": Result,
    "error": error,
    "success": success,
    "HasMore": HasMore,
    "TotalResults": TotalResults,
  };
}

