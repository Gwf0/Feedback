import 'package:bloc/bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:feedback24_app/authentication/authentication.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthenticationBloc authenticationBloc;
  final UserRepository userRepository;

  SignInBloc({required this.authenticationBloc, required this.userRepository})
      : super(UnAuthenticated()) {
    // When User Presses the SignIn Button, we will send the SignInRequested Event to the AuthBloc to handle it and emit the Authenticated State if the user is authenticated
    on<SignInRequested>((event, emit) async {
      emit(Loading());
      try {
        final UserModel user = await userRepository.signIn(
          phone: event.phone,
          password: event.password,
        );
        print("user: $user");
        authenticationBloc
          ..add(LoggedIn(
              token: user.token,
              id: user.id,
              lastName: user.lastName,
              firstName: user.firstName,
              phone: user.phone,
              role: user.role));
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    // When User Presses the SignOut Button, we will send the SignOutRequested Event to the AuthBloc to handle it and emit the UnAuthenticated State
    on<SignOutRequested>((event, emit) async {
      emit(Loading());
      await userRepository.deleteToken();
      emit(UnAuthenticated());
    });
  }
}
