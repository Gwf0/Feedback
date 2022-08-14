part of 'audit_details_bloc.dart';

abstract class AuditDetailsState extends Equatable {
  const AuditDetailsState();

  @override
  List<Object> get props => [];
}

class AuditDetailsInitial extends AuditDetailsState {}

class AuditDetailsLoading extends AuditDetailsState {}

class AuditDetailsLoaded extends AuditDetailsState {
  final AuditDetails auditDetails;
  final Instructions instructions;
  final Schedule schedule;

  const AuditDetailsLoaded({
    required this.auditDetails,
    required this.instructions,
    required this.schedule,
  });
}

class AuditDetailsError extends AuditDetailsState {
  final String message;
  const AuditDetailsError({
    required this.message,
  });
}
