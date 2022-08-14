class UserModel {
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.phone,
    required this.token,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  final int id;
  final String firstName;
  final String lastName;
  final String role;
  final String phone;
  final String token;
}

UserModel _$UserModelFromJson(Map<dynamic, dynamic> json) {
  return UserModel(
    firstName: 'Владимир',
    id: 1,
    lastName: 'Карев',
    phone: '+7 (961) 585-58-94',
    role: '',
    token: '',
  );
}
