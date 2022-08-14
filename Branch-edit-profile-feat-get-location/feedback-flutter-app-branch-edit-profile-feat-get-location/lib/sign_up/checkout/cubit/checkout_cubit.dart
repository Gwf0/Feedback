import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit(this.stepperLength) : super(const CheckoutState());
  final int stepperLength;

  void stepTapped(int tappedIndex) =>
      emit(state.copyWith(activeStepperIndex: tappedIndex));

  void stepContinued() {
    if (state.activeStepperIndex < stepperLength - 1) {
      emit(state.copyWith(activeStepperIndex: state.activeStepperIndex + 1));
    } else {
      emit(state.copyWith(activeStepperIndex: state.activeStepperIndex));
    }
  }

  void stepCancelled() {
    if (state.activeStepperIndex > 0) {
      emit(state.copyWith(activeStepperIndex: state.activeStepperIndex - 1));
    } else {
      emit(state.copyWith(activeStepperIndex: state.activeStepperIndex));
    }
  }

  void phoneChanged(String phone) => emit(state.copyWith(phone: phone));
  void codeChanged(String code) => emit(state.copyWith(code: code));
  void pass1Changed(String pass1) => emit(state.copyWith(pass1: pass1));
  void pass2Changed(String pass2) => emit(state.copyWith(pass2: pass2));
}
