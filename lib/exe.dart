import 'dart:convert';

Exerices exericesFromJson(String str) => Exerices.fromJson(json.decode(str));

String exericesToJson(Exerices data) => json.encode(data.toJson());

class Exerices {
  Exerices({
    this.name,
    this.job,
    this.id,
    this.createdAt,
  });

  String name;
  String job;
  String id;
  DateTime createdAt;

  factory Exerices.fromJson(Map<String, dynamic> json) => Exerices(
        name: json["name"],
        job: json["job"],
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "job": job,
        "id": id,
        "createdAt": createdAt.toIso8601String(),
      };
}
