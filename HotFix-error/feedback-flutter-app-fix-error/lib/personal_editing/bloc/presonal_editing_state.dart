part of 'presonal_editing_bloc.dart';

abstract class PresonalEditingState extends Equatable {
  const PresonalEditingState();
  @override
  List<Object> get props => [];
}

class PresonalEditingInitial extends PresonalEditingState {}

class PersonalEditingLoading extends PresonalEditingState {}

class PersonalEditingLoaded extends PresonalEditingState {
  final PersonalEdit personalEdit;
  const PersonalEditingLoaded({
    required this.personalEdit,
  });
}

class PersonalEditingError extends PresonalEditingState {
  final String message;
  const PersonalEditingError({
    required this.message,
  });
}
