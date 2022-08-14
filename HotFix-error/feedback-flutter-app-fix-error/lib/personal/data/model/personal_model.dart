import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class Personal extends Equatable {
  int? id;
  String? firstName;
  String? lastName;
  String? middleName;
  String? phone;
  String? role;
  String? email;
  City? city;
  DateTime? birthDate;
  bool? profileCompleted;
  int? inn;
  String? sex;
  String? education;
  String? activity;
  String? about;
  SelfemployedInfo? selfemployedInfo;

  String get formatedBirthDate => DateFormat.yMMMMd('ru_RU').format(birthDate!);

  Personal(
      {this.id,
      this.firstName,
      this.lastName,
      this.middleName,
      this.phone,
      this.role,
      this.email,
      this.city,
      this.birthDate,
      this.profileCompleted,
      this.inn,
      this.sex,
      this.education,
      this.activity,
      this.about,
      this.selfemployedInfo});

  Personal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    phone = json['phone'];
    role = json['role'];
    email = json['email'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    birthDate = DateTime.parse(json['birth_date']);
    profileCompleted = json['profile_completed'];
    inn = json['inn'];
    sex = json['sex'];
    education = json['education'];
    activity = json['activity'];
    about = json['about'];
    selfemployedInfo = json['selfemployed_info'] != null
        ? new SelfemployedInfo.fromJson(json['selfemployed_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['middle_name'] = this.middleName;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['email'] = this.email;
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    data['birth_date'] = this.birthDate;
    data['profile_completed'] = this.profileCompleted;
    data['inn'] = this.inn;
    data['sex'] = this.sex;
    data['education'] = this.education;
    data['activity'] = this.activity;
    data['about'] = this.about;
    if (this.selfemployedInfo != null) {
      data['selfemployed_info'] = this.selfemployedInfo!.toJson();
    }
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        middleName,
        phone,
        role,
        email,
        city,
        birthDate,
        profileCompleted,
        inn,
        sex,
        education,
        activity,
        about,
        selfemployedInfo,
      ];
}

class City {
  int? id;
  String? name;
  String? updatedAt;

  City({this.id, this.name, this.updatedAt});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class SelfemployedInfo {
  bool? isSelfemployed;
  String? selfemployedStatusMessage;
  String? checkedSelfemployedAt;
  int? inn;

  SelfemployedInfo(
      {this.isSelfemployed,
      this.selfemployedStatusMessage,
      this.checkedSelfemployedAt,
      this.inn});

  SelfemployedInfo.fromJson(Map<String, dynamic> json) {
    isSelfemployed = json['is_selfemployed'];
    selfemployedStatusMessage = json['selfemployed_status_message'];
    checkedSelfemployedAt = json['checked_selfemployed_at'];
    inn = json['inn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_selfemployed'] = this.isSelfemployed;
    data['selfemployed_status_message'] = this.selfemployedStatusMessage;
    data['checked_selfemployed_at'] = this.checkedSelfemployedAt;
    data['inn'] = this.inn;
    return data;
  }
}
