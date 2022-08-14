part of 'audits_bloc.dart';

abstract class AuditsState extends Equatable {
  const AuditsState();

  @override
  List<Object> get props => [];
}

class AuditsInitial extends AuditsState {}

class AuditsRefresh extends AuditsState {}

class AuditsLoading extends AuditsState {}

class AuditsLoaded extends AuditsState {
  final AuditList auditList;
  const AuditsLoaded({
    required this.auditList,
  });
}

class AuditsError extends AuditsState {
  final String message;
  const AuditsError({
    required this.message,
  });
}
