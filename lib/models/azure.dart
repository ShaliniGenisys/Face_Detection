// To parse this JSON data, do
//
//     final azure = azureFromJson(jsonString);

import 'dart:convert';

Azure azureFromJson(String str) => Azure.fromJson(json.decode(str));

String azureToJson(Azure data) => json.encode(data.toJson());

class Azure {
  Azure({
    this.message,
  });

  String message;

  factory Azure.fromJson(Map<String, dynamic> json) => Azure(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
