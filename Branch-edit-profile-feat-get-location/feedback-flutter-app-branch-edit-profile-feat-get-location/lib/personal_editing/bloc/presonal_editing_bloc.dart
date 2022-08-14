import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feedback24_app/personal_editing/data/repository/personal_edit_repository.dart';

import '../data/model/personal_edit.dart';

part 'presonal_editing_event.dart';
part 'presonal_editing_state.dart';

class PresonalEditingBloc
    extends Bloc<PresonalEditingEvent, PresonalEditingState> {
  final PersonalEditRepository personalEditRepository;
  PresonalEditingBloc({required this.personalEditRepository})
      : super(PresonalEditingInitial()) {
    on<PersonalEditFetchEvent>(_fetchEditingPersonal);
    on<PersonalEditAddEvent>(_fetchAddPersonal);
  }

  FutureOr<void> _fetchEditingPersonal(
      PersonalEditFetchEvent event, Emitter<PresonalEditingState> emit) async {
    try {
      emit(PersonalEditingLoading());
      final personalEdit = await personalEditRepository.personalResult();
      emit(PersonalEditingLoaded(personalEdit: personalEdit));
    } catch (e) {
      emit(PersonalEditingError(message: e.toString()));
    }
  }

  FutureOr<void> _fetchAddPersonal(
      PersonalEditAddEvent event, Emitter<PresonalEditingState> emit) async {
    try {
      emit(PersonalEditingLoading());

      final personalEdit = await personalEditRepository.personalAddResult(
          event.firstName,
          event.lastName,
          event.middleName,
          event.phone,
          event.email,
          event.inn,
          City(name: event.city),
          event.male,
          event.education,
          event.about,
          event.activity);
      emit(PersonalEditingLoaded(personalEdit: personalEdit));
    } catch (e) {
      emit(PersonalEditingError(message: e.toString()));
    }
  }
}
