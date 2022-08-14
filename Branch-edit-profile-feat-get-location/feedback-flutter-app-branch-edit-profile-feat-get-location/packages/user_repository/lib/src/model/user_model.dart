import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.phone,
    required this.token,
  });

  late final int id;
  late final String firstName;
  late final String lastName;
  late final String role;
  late final String phone;
  late final String token;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    role = json['role'];
    phone = json['phone'];
    token = json['token'];
  }
  UserModel.toJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    token = json['token'];
  }

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        role,
        phone,
        token,
      ];
}
