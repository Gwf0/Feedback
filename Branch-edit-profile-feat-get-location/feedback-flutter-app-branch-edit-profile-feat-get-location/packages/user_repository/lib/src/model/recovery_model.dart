import 'package:equatable/equatable.dart';

class RecoveryModel extends Equatable {
  RecoveryModel({
    required this.email,
  });
  late final int email;

  RecoveryModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  RecoveryModel.toJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  @override
  List<Object?> get props => [
        email,
      ];
}
