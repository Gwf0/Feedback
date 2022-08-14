import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feedback24_app/personal/data/model/personal_model.dart';
import '../data/repository/personal_repository.dart';

part 'personal_event.dart';
part 'personal_state.dart';

class PersonalBloc extends Bloc<PersonalEvent, PersonalState> {
  final PersonalRepository personalRepository;
  PersonalBloc({required this.personalRepository}) : super(PersonalInitial()) {
    on<PersonalFetchEvent>(_fetchCurrentUserPersonal);
  }

  FutureOr<void> _fetchCurrentUserPersonal(
      PersonalFetchEvent event, Emitter<PersonalState> emit) async {
    try {
      emit(PersonalLoading());
      final userPersonal = await personalRepository.getUserPersonalDetails();
      emit(PersonalLoaded(userPersonal: userPersonal));
    } catch (e) {
      emit(PersonalError(message: e.toString()));
    }
  }
}
