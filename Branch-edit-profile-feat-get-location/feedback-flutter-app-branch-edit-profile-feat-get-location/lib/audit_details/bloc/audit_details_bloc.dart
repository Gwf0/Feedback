import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feedback24_app/audit_details/data/repository/audit_details_repository.dart';

import '../data/model/audit_details_model.dart';

part 'audit_details_event.dart';
part 'audit_details_state.dart';

class AuditDetailsBloc extends Bloc<AuditDetailsEvent, AuditDetailsState> {
  final AuditDetailsRepository auditDetailsRepository;
  final AuditInstructionsRepository auditInstructionsRepository;
  final AuditShedulRepository auditShedulRepository;

  AuditDetailsBloc({
    required this.auditInstructionsRepository,
    required this.auditDetailsRepository,
    required this.auditShedulRepository,
  }) : super(AuditDetailsInitial()) {
    on<AuditDetailsFetchEvent>(_fetchAuditDetails);
    on<AuditDetailsSend>(_fetchSend);
  }

  FutureOr<void> _fetchAuditDetails(
      AuditDetailsFetchEvent event, Emitter<AuditDetailsState> emit) async {
    try {
      emit(AuditDetailsLoading());
      final auditDetails = await auditDetailsRepository.getAuditDetails('5643');
      final instructions =
          await auditInstructionsRepository.getAuditInstructions('18');
      final schedule = await auditShedulRepository.getAuditShedule('5643');
      emit(AuditDetailsLoaded(
        auditDetails: auditDetails,
        instructions: instructions,
        schedule: schedule,
      ));
      print(_fetchAuditDetails);
    } catch (e) {
      emit(AuditDetailsError(message: e.toString()));
    }
  }

  FutureOr<void> _fetchSend(
      AuditDetailsSend event, Emitter<AuditDetailsState> emit) async {
    try {
      emit(AuditDetailsLoading());
      final auditDetails = await auditDetailsRepository.getAuditDetails('5643');
      final instructions =
          await auditInstructionsRepository.getAuditInstructions('18');
      final schedule = await auditShedulRepository.postAudit('5643');
      emit(AuditDetailsLoaded(
        auditDetails: auditDetails,
        instructions: instructions,
        schedule: schedule,
      ));
      print(_fetchSend);
    } catch (e) {
      emit(AuditDetailsError(message: e.toString()));
    }
  }
}
