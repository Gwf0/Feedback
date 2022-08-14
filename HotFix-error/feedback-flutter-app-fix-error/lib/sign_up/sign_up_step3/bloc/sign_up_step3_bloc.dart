import 'package:equatable/equatable.dart';
import 'package:feedback24_app/authentication/bloc/authentication_bloc.dart';
import 'package:feedback24_app/sign_up/checkout/checkout.dart';
import 'package:feedback24_app/sign_up/sign_up_step3/models/models.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_step3_event.dart';
part 'sign_up_step3_state.dart';

class SignUpStep3Bloc extends Bloc<SignUpStep3Event, SignUpStep3State> {
  final UserRepository userRepository;
  final CheckoutCubit checkoutBloc;
  final AuthenticationBloc authenticationBloc;

  SignUpStep3Bloc({
    required this.authenticationBloc,
    required this.userRepository,
    required this.checkoutBloc,
  }) : super(const SignUpStep3State()) {
    on<Pass1Changed>(_onPass1Changed);
    on<Pass2Changed>(_onPass2Changed);
    on<FormStep3Submitted>(_onFormStep3Submitted);
  }

  void _onPass1Changed(
    Pass1Changed event,
    Emitter<SignUpStep3State> emit,
  ) {
    final pass1 = Pass1.dirty(event.pass1);
    emit(state.copyWith(
      pass1: pass1,
      status: Formz.validate([pass1, state.pass2]),
    ));
    print(event.pass1);
  }

  void _onPass2Changed(
    Pass2Changed event,
    Emitter<SignUpStep3State> emit,
  ) {
    final pass2 = Pass2.dirty(event.pass2);
    emit(state.copyWith(
      pass2: pass2,
      status: Formz.validate([state.pass1, pass2]),
    ));
    print(event.pass2);
  }

  void _onFormStep3Submitted(
    FormStep3Submitted event,
    Emitter<SignUpStep3State> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      print(checkoutBloc.state);

      try {
        final UserModel user = await userRepository.updateSignUpStep3(
          code: checkoutBloc.state.code,
          phone: checkoutBloc.state.phone,
          pass1: state.pass1.value,
          pass2: state.pass2.value,
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
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
    print(FormzStatus.submissionSuccess);
  }
}
