part of 'presonal_editing_bloc.dart';

abstract class PresonalEditingEvent extends Equatable {
  const PresonalEditingEvent();

  @override
  List<Object> get props => [];
}

class PersonalEditFetchEvent extends PresonalEditingEvent {}

class PersonalEditAddEvent extends PresonalEditingEvent {
  final String phone;
  final String email;
  final String lastName;
  final String middleName;
  final String firstName;
  final String inn;

  PersonalEditAddEvent(this.phone, this.email, this.lastName, this.middleName,
      this.firstName, this.inn);
}
