import 'package:equatable/equatable.dart';
import 'package:feedback24_app/sign_up/sign_up_step1/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_step1_event.dart';
part 'sign_up_step1_state.dart';

class SignUpStep1Bloc extends Bloc<SignUpStep1SEvent, SignUpStep1State> {
  final UserRepository userRepository;

  SignUpStep1Bloc({required this.userRepository})
      : super(const SignUpStep1State()) {
    on<FirstnameChanged>(_onFirstnameChanged);
    on<LastnameChanged>(_onLastnameChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<FormStep1Submitted>(_onFormStep1Submitted);
  }

  void _onFirstnameChanged(
    FirstnameChanged event,
    Emitter<SignUpStep1State> emit,
  ) {
    final firstname = FirstName.dirty(event.firstname);
    emit(state.copyWith(
      firstname: firstname,
      status: Formz.validate([firstname, state.firstname, state.phone]),
    ));
  }

  void _onLastnameChanged(
    LastnameChanged event,
    Emitter<SignUpStep1State> emit,
  ) {
    final lastname = LastName.dirty(event.lastname);
    emit(state.copyWith(
      lastname: lastname,
      status: Formz.validate([state.lastname, lastname, state.phone]),
    ));
  }

  void _onPhoneChanged(
    PhoneChanged event,
    Emitter<SignUpStep1State> emit,
  ) {
    final phone = PhoneNumber.dirty(event.phone);
    emit(state.copyWith(
      phone: phone,
      status: Formz.validate([state.firstname, state.lastname, phone]),
    ));
  }

  void _onFormStep1Submitted(
    FormStep1Submitted event,
    Emitter<SignUpStep1State> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await userRepository.updateSignUpStep1(
          phone: state.phone.value,
          firstName: state.firstname.value,
          lastName: state.lastname.value,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
