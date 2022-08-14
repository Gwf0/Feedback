part of 'personal_bloc.dart';

abstract class PersonalEvent extends Equatable {
  const PersonalEvent();

  @override
  List<Object> get props => [];
}

class PersonalFetchEvent extends PersonalEvent {}
