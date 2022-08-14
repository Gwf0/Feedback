import 'dart:convert';

Quiz quizFromJson(String str) => Quiz.fromJson(json.decode(str));

String quizToJson(Quiz data) => json.encode(data.toJson());

class Quiz {
  Quiz({
    required this.result,
    required this.count,
  });

  List<Result> result;
  int count;

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
        "count": count,
      };
}

class Result {
  Result({
    required this.id,
    required this.type,
    required this.title,
    required this.score,
    required this.artifacts,
    required this.item,
    required this.titles,
    required this.answer,
    required this.attachments,
  });

  int id;
  String type;
  String title;
  int score;
  List<String> artifacts;
  Item item;
  List<String> titles;
  Answer answer;
  List<dynamic> attachments;

  factory Result.fromJson(Map<String, dynamic> json) {
    var result = Result(
      id: json["id"],
      type: json["type"],
      title: json["title"],
      score: json["score"],
      artifacts: List<String>.from(json["artifacts"].map((x) => x)),
      item: Item.fromJson(json["item"]),
      titles: List<String>.from(json["titles"].map((x) => x)),
      answer: Answer.fromJson(json["answer"]),
      attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
    );
    return result;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "title": title,
        "score": score,
        "artifacts": List<dynamic>.from(artifacts.map((x) => x)),
        "item": item.toJson(),
        "titles": List<dynamic>.from(titles.map((x) => x)),
        "answer": answer.toJson(),
        "attachments": List<dynamic>.from(attachments.map((x) => x)),
      };
}

class Answer {
  Answer({
    required this.id,
    required this.reportId,
    required this.questionId,
    this.answer,
    this.comment,
    this.timecode,
    this.accepted,
    required this.createdAt,
    this.status,
    this.message,
    this.extra,
    this.answerOld,
    this.value,
    required this.updatedAt,
  });

  int id;
  int reportId;
  int questionId;
  dynamic answer;
  dynamic comment;
  dynamic timecode;
  dynamic accepted;
  DateTime createdAt;
  dynamic status;
  dynamic message;
  dynamic extra;
  dynamic answerOld;
  dynamic value;
  DateTime updatedAt;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        id: json["id"],
        reportId: json["report_id"],
        questionId: json["question_id"],
        answer: json["answer"],
        comment: json["comment"],
        timecode: json["timecode"],
        accepted: json["accepted"],
        createdAt: DateTime.parse(json["created_at"]),
        status: json["status"],
        message: json["message"],
        extra: json["extra"],
        answerOld: json["answer_old"],
        value: json["value"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "report_id": reportId,
        "question_id": questionId,
        "answer": answer,
        "comment": comment,
        "timecode": timecode,
        "accepted": accepted,
        "created_at": createdAt.toIso8601String(),
        "status": status,
        "message": message,
        "extra": extra,
        "answer_old": answerOld,
        "value": value,
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Item {
  Item({
    required this.id,
    required this.kind,
    required this.title,
    required this.weight,
    required this.control,
    required this.enabled,
    required this.artifacts,
    required this.description,
  });

  String id;
  String kind;
  String title;
  int weight;
  Control control;
  bool enabled;
  List<String> artifacts;
  String description;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        kind: json["kind"],
        title: json["title"],
        weight: json["weight"],
        control: Control.fromJson(json["control"]),
        enabled: json["enabled"],
        artifacts: List<String>.from(json["artifacts"].map((x) => x)),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kind": kind,
        "title": title,
        "weight": weight,
        "control": control.toJson(),
        "enabled": enabled,
        "artifacts": List<dynamic>.from(artifacts.map((x) => x)),
        "description": description,
      };
}

class Control {
  Control({
    required this.type,
    required this.options,
  });

  String type;
  List<Option> options;

  factory Control.fromJson(Map<String, dynamic> json) => Control(
        type: json["type"],
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
      };
}

class Option {
  Option({
    required this.name,
    required this.label,
    required this.point,
    required this.right,
  });

  String name;
  String label;
  int point;
  bool right;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        name: json["name"],
        label: json["label"],
        point: json["point"],
        right: json["right"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "label": label,
        "point": point,
        "right": right,
      };
}
