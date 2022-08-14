part of 'audits_bloc.dart';

abstract class AuditsEvent extends Equatable {
  const AuditsEvent();

  @override
  List<Object> get props => [];
}

class AuditsFetchEvent extends AuditsEvent {}
