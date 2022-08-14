part of 'audit_details_bloc.dart';

abstract class AuditDetailsEvent extends Equatable {
  const AuditDetailsEvent();

  @override
  List<Object> get props => [];
}

class AuditDetailsFetchEvent extends AuditDetailsEvent {}

class AuditDetailsSend extends AuditDetailsEvent {
  final String shedule;

  AuditDetailsSend(this.shedule);
}
