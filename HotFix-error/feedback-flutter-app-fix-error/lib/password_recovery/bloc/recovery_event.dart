part of 'recovery_bloc.dart';

@immutable
abstract class RecoveryEvent extends Equatable {
  List<Object> get props => [];
}

class RecoveryPass extends RecoveryEvent {
  final String email;

  RecoveryPass(this.email);
}

// When the user signing out this event is called and the [AuthRepository] is called to sign out the user
class RecoveryRequested extends RecoveryEvent {}
