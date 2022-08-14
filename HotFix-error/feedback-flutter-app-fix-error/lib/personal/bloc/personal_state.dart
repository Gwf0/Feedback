part of 'personal_bloc.dart';

abstract class PersonalState extends Equatable {
  const PersonalState();

  @override
  List<Object> get props => [];
}

class PersonalInitial extends PersonalState {}

class PersonalLoading extends PersonalState {}

class PersonalLoaded extends PersonalState {
  final Personal userPersonal;
  const PersonalLoaded({
    required this.userPersonal,
  });
}

class PersonalError extends PersonalState {
  final String message;
  const PersonalError({
    required this.message,
  });
}
