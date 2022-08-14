import 'package:equatable/equatable.dart';
import 'package:feedback24_app/sign_up/checkout/checkout.dart';
import 'package:feedback24_app/sign_up/sign_up_step2/models/sign_up_step2_otp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_step2_event.dart';
part 'sign_up_step2_state.dart';

class SignUpStep2Bloc extends Bloc<SignUpStep2Event, SignUpStep2State> {
  final UserRepository userRepository;
  final CheckoutCubit checkoutBloc;
  SignUpStep2Bloc({required this.userRepository, required this.checkoutBloc})
      : super(const SignUpStep2State()) {
    on<PostcodeChanged>(_onPostcodeChanged);
    on<FormStep2Submitted>(_onFormStep2Submitted);
  }

  void _onPostcodeChanged(
    PostcodeChanged event,
    Emitter<SignUpStep2State> emit,
  ) {
    final code = Code.dirty(event.code);
    emit(state.copyWith(
      code: code,
      status: Formz.validate([code]),
    ));
  }

  void _onFormStep2Submitted(
    FormStep2Submitted event,
    Emitter<SignUpStep2State> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await userRepository.updateSignUpStep2(
          code: state.code.value,
          phone: checkoutBloc.state.phone,
        );

        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
