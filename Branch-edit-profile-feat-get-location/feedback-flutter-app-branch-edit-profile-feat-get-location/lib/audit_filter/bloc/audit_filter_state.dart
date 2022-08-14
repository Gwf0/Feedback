part of 'audit_filter_bloc.dart';

abstract class AuditFilterState extends Equatable {
  const AuditFilterState();
  
  @override
  List<Object> get props => [];
}

class AuditFilterInitial extends AuditFilterState {}
