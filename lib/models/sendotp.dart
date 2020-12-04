// To parse this JSON data, do
//
//     final sendotp = sendotpFromJson(jsonString);

import 'dart:convert';

Sendotp sendotpFromJson(String str) => Sendotp.fromJson(json.decode(str));

String sendotpToJson(Sendotp data) => json.encode(data.toJson());

class Sendotp {
  Sendotp({
    this.message,
  });

  String message;

  factory Sendotp.fromJson(Map<String, dynamic> json) => Sendotp(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
