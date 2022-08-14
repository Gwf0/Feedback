import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Audit extends Equatable {
  final int id;
  final String type;
  final bool confirmLocation;
  final DateTime publishedAt;
  final DateTime expirationDate;
  final Entity entity;
  final int rewardAmount;
  final int refundAmount;
  final String comment;

  String get formatedPublishedAt =>
      DateFormat.yMMMMd('ru_RU').format(publishedAt);
  String get formatedExpirationDate =>
      DateFormat.yMMMMd('ru_RU').format(expirationDate);

  const Audit(
      {required this.id,
      required this.type,
      required this.confirmLocation,
      required this.publishedAt,
      required this.expirationDate,
      required this.entity,
      required this.rewardAmount,
      required this.refundAmount,
      required this.comment});

  factory Audit.fromJson(Map<String, dynamic> data) => Audit(
      id: data['id'] as int,
      type: data['type'] as String,
      confirmLocation: data['confirm_location'] as bool,
      publishedAt: DateTime.parse(data['published_at'] as String),
      expirationDate: DateTime.parse(data['expiration_date'] as String),
      rewardAmount: data['reward_amount'] as int,
      refundAmount: data['refund_amount'] as int,
      comment: data['comment'] as String,
      entity: new Entity.fromJson(data['entity'] as Map<String, dynamic>));

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
        comment
      ];
}

class Entity extends Equatable {
  final int id;
  final String name;
  final String address;

  const Entity({required this.id, required this.name, required this.address});

  factory Entity.fromJson(Map<String, dynamic> data) => Entity(
        id: data['id'] as int,
        name: data['public_name'] as String,
        address: data['address'] as String,
      );

  @override
  List<Object?> get props => [id, name, address];
}

class AuditList extends Equatable {
  final List<Audit> audits;
  final int total;

  const AuditList({required this.audits, required this.total});

  factory AuditList.fromJson(Map<String, dynamic> data) {
    final auditsData = data['results'] as List<dynamic>;
    final total = data['total'] as int;

    final audits =
        auditsData.map((reviewData) => Audit.fromJson(reviewData)).toList();

    return AuditList(audits: audits, total: total);
  }

  @override
  List<Object?> get props => [audits, total];
}
