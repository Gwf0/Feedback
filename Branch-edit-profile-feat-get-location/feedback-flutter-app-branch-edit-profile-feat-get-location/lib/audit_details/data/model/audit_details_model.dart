// ignore_for_file: unnecessary_null_comparison

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class AuditDetails extends Equatable {
  final int id;
  final String type;
  final bool confirmLocation;
  final DateTime publishedAt;
  final DateTime expirationDate;
  final Entity entity;
  final int rewardAmount;
  final int refundAmount;
  final String comment;
  final DoerRequirements doerRequirements;
  final Checklist checklist;
  final ChecklistElement checklistElement;

  String get formatedPublishedAt =>
      DateFormat.yMMMMd('ru_RU').format(publishedAt);
  String get formatedExpirationDate =>
      DateFormat.yMMMMd('ru_RU').format(expirationDate);

  const AuditDetails({
    required this.id,
    required this.type,
    required this.confirmLocation,
    required this.publishedAt,
    required this.expirationDate,
    required this.entity,
    required this.rewardAmount,
    required this.refundAmount,
    required this.comment,
    required this.doerRequirements,
    required this.checklist,
    required this.checklistElement,
  });

  factory AuditDetails.fromJson(Map<String, dynamic> data) => AuditDetails(
        id: data['id'] as int,
        type: data['type'] as String,
        confirmLocation: data['confirm_location'] as bool,
        publishedAt: DateTime.parse(data['published_at'] as String),
        expirationDate: DateTime.parse(data['expiration_date'] as String),
        rewardAmount: data['reward_amount'] as int,
        refundAmount: data['refund_amount'] as int,
        comment: data['comment'] as String,
        entity: new Entity.fromJson(data['entity'] as Map<String, dynamic>),
        doerRequirements: new DoerRequirements.fromJson(
            data['doer_requirements'] as Map<String, dynamic>),
        checklist: new Checklist.fromJson(
            data['checklist'][0] as Map<String, dynamic>),
        checklistElement: new ChecklistElement.fromJson(
            data['checklist'][0] as Map<String, dynamic>),
      );

  @override
  List<Object?> get props => [
        id,
        type,
        confirmLocation,
        publishedAt,
        expirationDate,
        entity,
        rewardAmount,
        refundAmount,
        comment,
        doerRequirements,
        checklist,
        checklistElement,
      ];
}

class DoerRequirements extends Equatable {
  final int age;
  final String sex;
  final String education;

  const DoerRequirements({
    required this.age,
    required this.education,
    required this.sex,
  });

  factory DoerRequirements.fromJson(Map<String, dynamic> data) =>
      DoerRequirements(
        age: data['age'][0] as int,
        sex: data['sex'] as String,
        education: data['education'] as String,
      );

  @override
  List<Object?> get props => [age, sex, education];
}

class Entity extends Equatable {
  final int id;
  final String name;
  final String address;

  const Entity({
    required this.id,
    required this.name,
    required this.address,
  });

  factory Entity.fromJson(Map<String, dynamic> data) => Entity(
        id: data['id'] as int,
        name: data['public_name'] as String,
        address: data['address'] as String,
      );

  @override
  List<Object?> get props => [id, name, address];
}

Checklist checklistFromJson(String str) => Checklist.fromJson(json.decode(str));

String checklistToJson(Checklist data) => json.encode(data.toJson());

class Checklist {
  Checklist({
    required this.checklist,
  });

  List<ChecklistElement> checklist;

  factory Checklist.fromJson(Map<String, dynamic> json) => Checklist(
      checklist: ((json["checklist"] ?? []) as List)
          .map((x) => ChecklistElement.fromJson(x))
          .toList());

  Map<String, dynamic> toJson() => {
        "checklist": List<dynamic>.from(checklist.map((x) => x.toJson())),
      };
}

class ChecklistElement {
  ChecklistElement({
    required this.id,
    required this.type,
    required this.score,
    required this.title,
    required this.children,
    required this.artifacts,
    this.eurotexId,
  });

  int id;
  String type;
  int score;
  String title;
  List<ChecklistElement> children;
  List<dynamic> artifacts;
  dynamic eurotexId;

  factory ChecklistElement.fromJson(Map<String, dynamic> json) =>
      ChecklistElement(
        id: json["id"],
        type: json["type"],
        score: json["score"],
        title: json["title"],
        children: List<ChecklistElement>.from(
            json["children"].map((x) => ChecklistElement.fromJson(x))),
        artifacts: List<dynamic>.from(json["artifacts"].map((x) => x)),
        eurotexId: json["eurotex_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "score": score,
        "title": title,
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
        "artifacts": List<dynamic>.from(artifacts.map((x) => x)),
        "eurotex_id": eurotexId,
      };
}

Instructions instructionsFromJson(String str) =>
    Instructions.fromJson(json.decode(str));

String instructionsToJson(Instructions data) => json.encode(data.toJson());

class Instructions {
  Instructions({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.contentHtml,
    required this.attachments,
  });

  int id;
  String title;
  String content;
  DateTime createdAt;
  String contentHtml;
  List<dynamic> attachments;

  factory Instructions.fromJson(Map<String, dynamic> json) => Instructions(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
        contentHtml: json["content_html"],
        attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "created_at": createdAt.toIso8601String(),
        "content_html": contentHtml,
        "attachments": List<dynamic>.from(attachments.map((x) => x)),
      };
}

class Schedule {
  Schedule({
    required this.dates,
    required this.intervals,
  });

  List<Date> dates;
  List<Interval> intervals;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        dates: ((json["dates"] ?? []) as List)
            .map((i) => Date.fromJson(i))
            .toList(),
        intervals: ((json["intervals"] ?? []) as List)
            .map((i) => Interval.fromJson(i))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "dates": List<dynamic>.from(dates.map((x) => x.toJson())),
        "intervals": List<dynamic>.from(intervals.map((x) => x.toJson())),
      };
}

class Date {
  Date({
    required this.date,
    required this.hours,
  });

  String date;
  List<List<String>> hours;

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        date: json["date"],
        hours: List<List<String>>.from(
            json["hours"].map((x) => List<String>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "hours": List<dynamic>.from(
            hours.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

class Interval {
  Interval({
    required this.interval,
    required this.timetable,
    required this.isTimetable,
  });

  List<String> interval;
  Timetable timetable;
  bool isTimetable;

  factory Interval.fromJson(Map<String, dynamic> json) => Interval(
        interval: List<String>.from(json["interval"].map((x) => x)),
        timetable: Timetable.fromJson(json["timetable"]),
        isTimetable: json["isTimetable"],
      );

  Map<String, dynamic> toJson() => {
        "interval": List<dynamic>.from(interval.map((x) => x)),
        "timetable": timetable.toJson(),
        "isTimetable": isTimetable,
      };
}

class Timetable {
  Timetable({
    required this.friday,
    required this.monday,
    required this.sunday,
    required this.tuesday,
    required this.isDelay,
    required this.saturday,
    required this.thursday,
    required this.wednesday,
  });

  Day friday;
  Day monday;
  Day sunday;
  Day tuesday;
  bool isDelay;
  Day saturday;
  Day thursday;
  Day wednesday;

  factory Timetable.fromJson(Map<String, dynamic> json) => Timetable(
        friday: Day.fromJson(json["friday"]),
        monday: Day.fromJson(json["monday"]),
        sunday: Day.fromJson(json["sunday"]),
        tuesday: Day.fromJson(json["tuesday"]),
        isDelay: json["is_delay"],
        saturday: Day.fromJson(json["saturday"]),
        thursday: Day.fromJson(json["thursday"]),
        wednesday: Day.fromJson(json["wednesday"]),
      );

  Map<String, dynamic> toJson() => {
        "friday": friday.toJson(),
        "monday": monday.toJson(),
        "sunday": sunday.toJson(),
        "tuesday": tuesday.toJson(),
        "is_delay": isDelay,
        "saturday": saturday.toJson(),
        "thursday": thursday.toJson(),
        "wednesday": wednesday.toJson(),
      };
}

class Day {
  Day({
    required this.delay,
    required this.hours,
    required this.isWorking,
  });

  Delay delay;
  Delay hours;
  bool isWorking;

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        delay: Delay.fromJson(json["delay"]),
        hours: Delay.fromJson(json["hours"]),
        isWorking: json["is_working"],
      );

  Map<String, dynamic> toJson() => {
        "delay": delay.toJson(),
        "hours": hours.toJson(),
        "is_working": isWorking,
      };
}

class Delay {
  Delay({
    required this.end,
    required this.start,
  });

  String end;
  String start;

  factory Delay.fromJson(Map<String, dynamic> json) => Delay(
        end: json["end"] == null ? null : json["end"],
        start: json["start"] == null ? null : json["start"],
      );

  Map<String, dynamic> toJson() => {
        "end": end == null ? null : end,
        "start": start == null ? null : start,
      };
}
