import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({required this.userRepository}) : super(UnInitialized()) {
    on<AppStarted>((event, emit) async {
      final bool hasToken = await userRepository.hasToken();
      await Future<void>.delayed(const Duration(seconds: 1));
      hasToken ? emit(Authenticated()) : emit(UnAuthenticated());
    });

    on<LoggedIn>((event, emit) async {
      await userRepository.persistToken(event.token);
      emit(Authenticated());
    });

    on<LoggedOut>((event, emit) async {
      await userRepository.deleteToken();
      emit(UnAuthenticated());
    });
  }
}
