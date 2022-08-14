import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'audit_filter_event.dart';
part 'audit_filter_state.dart';

class AuditFilterBloc extends Bloc<AuditFilterEvent, AuditFilterState> {
  AuditFilterBloc() : super(AuditFilterInitial()) {
    on<AuditFilterEvent>((event, emit) {});
  }
}
