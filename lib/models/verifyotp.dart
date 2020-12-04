// To parse this JSON data, do
//
//     final verifyotp = verifyotpFromJson(jsonString);

import 'dart:convert';

Verifyotp verifyotpFromJson(String str) => Verifyotp.fromJson(json.decode(str));

String verifyotpToJson(Verifyotp data) => json.encode(data.toJson());

class Verifyotp {
  Verifyotp({
    this.message,
  });

  String message;

  factory Verifyotp.fromJson(Map<String, dynamic> json) => Verifyotp(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
