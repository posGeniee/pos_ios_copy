// To parse this JSON data, do
//
//     final departmentModel = departmentModelFromMap(jsonString);

import 'dart:convert';

DepartmentModel departmentModelFromMap(String str) =>
    DepartmentModel.fromMap(json.decode(str));

String departmentModelToMap(DepartmentModel data) => json.encode(data.toMap());

class DepartmentModel {
  DepartmentModel({
    required this.code,
    required this.message,
  });

  int code;
  MessageDepartment? message;

  factory DepartmentModel.fromMap(Map<String, dynamic> json) => DepartmentModel(
        code: json["code"] == null ? null.toString() : json["code"],
        message: json["message"] == null
            ? MessageDepartment(
                currentPage: 0,
                data: [],
                firstPageUrl: '',
                from: 0,
                lastPage: 0,
                lastPageUrl: '',
                links: [],
                nextPageUrl: '',
                path: '',
                perPage: 0,
                prevPageUrl: '',
                to: 0,
                total: 0)
            : MessageDepartment.fromMap(json["message"]),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null.toString() : code,
        "message": message == null ? null.toString() : message!.toMap(),
      };
}

class MessageDepartment {
  MessageDepartment({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  int currentPage;
  List<DatumDepartment>? data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<LinkDepartment>? links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory MessageDepartment.fromMap(Map<String, dynamic> json) =>
      MessageDepartment(
        currentPage: json["current_page"] == null
            ? 0
            : json["current_page"],
        data: json["data"] == null
            ? []
            : List<DatumDepartment>.from(
                json["data"].map((x) => DatumDepartment.fromMap(x))),
        firstPageUrl: json["first_page_url"] == null
            ? null.toString()
            : json["first_page_url"],
        from: json["from"] == null ? 1 : json["from"],
        lastPage: json["last_page"] == null ? 1 : json["last_page"],
        lastPageUrl: json["last_page_url"] == null
            ? ''
            : json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<LinkDepartment>.from(
                json["links"].map((x) => LinkDepartment.fromMap(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"] == null ? null.toString() : json["path"],
        perPage: json["per_page"] == null ? 1 : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? 1 : json["to"],
        total: json["total"] == null ? 1 : json["total"],
      );

  Map<String, dynamic> toMap() => {
        "current_page": currentPage == null ? null.toString() : currentPage,
        "data": data == null
            ? null.toString()
            : List<dynamic>.from(data!.map((x) => x.toMap())),
        "first_page_url": firstPageUrl == null ? null.toString() : firstPageUrl,
        "from": from == null ? null.toString() : from,
        "last_page": lastPage == null ? null.toString() : lastPage,
        "last_page_url": lastPageUrl == null ? null.toString() : lastPageUrl,
        "links": links == null
            ? null.toString()
            : List<dynamic>.from(links!.map((x) => x.toMap())),
        "next_page_url": nextPageUrl,
        "path": path == null ? null.toString() : path,
        "per_page": perPage == null ? null.toString() : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null.toString() : to,
        "total": total == null ? null.toString() : total,
      };
}

class DatumDepartment {
  DatumDepartment({
    required this.name,
    required this.id,
  });

  String name;
  int id;

  factory DatumDepartment.fromMap(Map<String, dynamic> json) => DatumDepartment(
        name: json["name"] == null ? null.toString() : json["name"],
        id: json["id"] == null ? 0 : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null.toString() : name,
        "id": id == null ? null.toString() : id,
      };
}

class LinkDepartment {
  LinkDepartment({
    required this.url,
    required this.label,
    required this.active,
  });

  String url;
  String label;
  bool active;

  factory LinkDepartment.fromMap(Map<String, dynamic> json) => LinkDepartment(
        url: json["url"] == null ? null.toString() : json["url"],
        label: json["label"] == null ? null.toString() : json["label"],
        active: json["active"] == null ? false : json["active"],
      );

  Map<String, dynamic> toMap() => {
        "url": url == null ? null.toString() : url,
        "label": label == null ? null.toString() : label,
        "active": active == null ? null.toString() : active,
      };
}
