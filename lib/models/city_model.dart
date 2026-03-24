// To parse this JSON data, do
//
//     final city = cityFromJson(jsonString);

import 'dart:convert';

City cityFromJson(String str) => City.fromJson(json.decode(str));

String cityToJson(City data) => json.encode(data.toJson());

class City {
  String code;
  String name;

  City({required this.code, required this.name});

  factory City.fromJson(Map<String, dynamic> json) =>
      City(code: json["code"], name: json["name"]);

  Map<String, dynamic> toJson() => {"code": code, "name": name};

  @override
  String toString() => name; // 🔥 penting buat tampil di dropdown
}
