import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Payment extends Equatable {
  Payment({
    required this.currentAccount,
    required this.bik,
  });

  String currentAccount;
  String bik;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        currentAccount: json["current_account"],
        bik: json["bik"],
      );

  Map<String, dynamic> toJson() => {
        "current_account": currentAccount,
        "bik": bik,
      };
  @override
  List<Object?> get props => [bik, currentAccount];
}
