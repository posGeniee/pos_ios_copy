// To parse this JSON data, do
//
//     final eventModel = eventModelFromMap(jsonString);

import 'dart:convert';

EventModel eventModelFromMap(String str) =>
    EventModel.fromMap(json.decode(str));

String eventModelToMap(EventModel data) => json.encode(data.toMap());

class EventModel {
  EventModel({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  List<EventModelDatum> data;

  factory EventModel.fromMap(Map<String, dynamic> json) => EventModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? []
            : List<EventModelDatum>.from(
                json["data"].map((x) => EventModelDatum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class EventModelDatum {
  EventModelDatum({
    required this.title,
    required this.start,
    required this.end,
    required this.name,
    required this.repeat,
    required this.allDay,
  });

  String title;
  DateTime? start;
  DateTime? end;
  String name;
  String repeat;
  bool allDay;

  factory EventModelDatum.fromMap(Map<String, dynamic> json) => EventModelDatum(
        title: json["title"] == null ? '' : json["title"],
        start: json["start"] == null
            ? DateTime.now()
            : DateTime.parse(json["start"]),
        end: json["end"] == null ? DateTime.now() : DateTime.parse(json["end"]),
        name: json["name"] == null ? '' : json["name"],
        repeat: json["repeat"] == null ? '' : json["repeat"],
        allDay: json["allDay"] == null ? '' : json["allDay"],
      );

  Map<String, dynamic> toMap() => {
        "title": title == null ? null : title,
        "start": start == null ? null : start!.toIso8601String(),
        "end": end == null ? null : end!.toIso8601String(),
        "name": name == null ? null : name,
        "repeat": repeat == null ? null : repeat,
        "allDay": allDay == null ? null : allDay,
      };
}
