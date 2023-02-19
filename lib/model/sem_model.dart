import 'dart:convert';

List<SemItem> semDataFromJson(String str) =>
    List<SemItem>.from(json.decode(str).map((x) => SemItem.fromJson(x)));

String semDataToJson(List<SemItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SemItem {
  SemItem({
    required this.title,
    required this.img,
  });

  String title;
  String img;

  factory SemItem.fromJson(Map<String, dynamic> json) => SemItem(
    title: json["title"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "img": img,
  };
}

