part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

// Запуск приложения
class AppStarted extends AuthenticationEvent {}

// Выполнен вход в систему
class LoggedIn extends AuthenticationEvent {
  final String token;
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final String role;

  const LoggedIn({
    required this.token,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.role,
  });

  @override
  List<Object> get props => [
        token,
        id,
        firstName,
        lastName,
        phone,
        role,
      ];

  @override
  String toString() =>
      'LoggedIn { token: $token id: $id  firstName: $firstName lastName: $lastName phone: $phone role: $role}';
}

// Выполнен выход из системы
class LoggedOut extends AuthenticationEvent {
  LoggedOut();
}
