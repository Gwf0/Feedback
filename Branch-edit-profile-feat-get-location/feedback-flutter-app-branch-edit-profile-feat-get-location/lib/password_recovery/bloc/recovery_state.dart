part of 'recovery_bloc.dart';

@immutable
abstract class RecoveryState extends Equatable {}

class Loading extends RecoveryState {
  @override
  List<Object?> get props => [];
}

class PhoneAuth extends RecoveryState {
  @override
  List<Object?> get props => [];
}

class UnPhoneAuth extends RecoveryState {
  @override
  List<Object?> get props => [];
}

class AuthError extends RecoveryState {
  final String error;

  AuthError(this.error);
  @override
  List<Object?> get props => [error];
}
