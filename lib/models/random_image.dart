// To parse this JSON data, do
//
//     final randomImage = randomImageFromJson(jsonString);

import 'dart:convert';

RandomImage randomImageFromJson(String str) => RandomImage.fromJson(json.decode(str));

String randomImageToJson(RandomImage data) => json.encode(data.toJson());

class RandomImage {
  final String message;
  final String status;

  RandomImage({
    required this.message,
    required this.status,
  });

  factory RandomImage.fromJson(Map<String, dynamic> json) => RandomImage(
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
  };
}
