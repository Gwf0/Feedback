part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// When the user signing in with email and password this event is called and the [AuthRepository] is called to sign in the user
class SignInRequested extends SignInEvent {
  final String phone;
  final String password;

  SignInRequested(this.phone, this.password);
}

// When the user signing out this event is called and the [AuthRepository] is called to sign out the user
class SignOutRequested extends SignInEvent {}
