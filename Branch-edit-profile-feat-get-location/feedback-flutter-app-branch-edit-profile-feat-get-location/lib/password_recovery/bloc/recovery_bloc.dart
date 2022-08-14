import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
// ignore: implementation_imports
import 'package:user_repository/src/model/recovery_model.dart';
import 'package:user_repository/user_repository.dart';

part 'recovery_event.dart';
part 'recovery_state.dart';

class RecoveryBloc extends Bloc<RecoveryEvent, RecoveryState> {
  RecoveryBloc({
    required UserRepository userRepository,
  }) : super(PhoneAuth()) {
    on<RecoveryPass>((event, emit) async {
      emit(Loading());
      try {
        final RecoveryModel user = await userRepository.recoveryPass(
          email: event.email,
        );
        print("user: $user");
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnPhoneAuth());
      }
    });
  }
}
