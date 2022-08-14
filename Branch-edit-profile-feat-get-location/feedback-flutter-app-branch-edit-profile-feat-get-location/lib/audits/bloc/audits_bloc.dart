import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feedback24_app/audits/data/model/audit_model.dart';

import 'package:feedback24_app/audits/data/repository/audit_repository.dart';

part 'audits_event.dart';
part 'audits_state.dart';

class AuditsBloc extends Bloc<AuditsEvent, AuditsState> {
  final AuditRepository auditRepository;

  AuditsBloc({
    required this.auditRepository,
  }) : super(AuditsInitial()) {
    on<AuditsFetchEvent>(_fetchAudits);
  }

  FutureOr<void> _fetchAudits(
      AuditsFetchEvent event, Emitter<AuditsState> emit) async {
    try {
      final auditList = await auditRepository.getAudits();
      emit(AuditsLoading());

      emit(AuditsLoaded(auditList: auditList));
      print(_fetchAudits);
    } catch (e) {
      emit(AuditsError(message: e.toString()));
    }
  }
}
