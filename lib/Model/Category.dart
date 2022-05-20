// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    required this.Id,
    required this.AdminId,
    required this.CategoryName,
    required this.Active,
    required this.CreatedBy,
    required this.CreatedOn,
    required this.UpdatedBy,
    required this.UpdatedOn,
  });

  int Id;
  int AdminId;
  String CategoryName;
  int Active;
  String CreatedBy;
  String CreatedOn;
  String UpdatedBy;
  String UpdatedOn;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    Id: json["Id"],
    AdminId: json["AdminId"],
    CategoryName: json["CategoryName"],
    Active: json["Active"],
    CreatedBy: json["CreatedBy"],
    CreatedOn: json["CreatedOn"],
    UpdatedBy: json["UpdatedBy"],
    UpdatedOn: json["UpdatedOn"],
  );

  Map<String, dynamic> toJson() => {
    "Id": Id,
    "AdminId": AdminId,
    "CategoryName": CategoryName,
    "Active": Active,
    "CreatedBy": CreatedBy,
    "CreatedOn": CreatedOn,
    "UpdatedBy": UpdatedBy,
    "UpdatedOn": UpdatedOn,
  };
}
