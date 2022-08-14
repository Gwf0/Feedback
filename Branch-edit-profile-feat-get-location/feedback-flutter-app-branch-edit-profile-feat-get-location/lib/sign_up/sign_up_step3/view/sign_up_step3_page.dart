import 'package:feedback24_app/authentication/bloc/authentication_bloc.dart';
import 'package:feedback24_app/sign_up/checkout/cubit/checkout_cubit.dart';
import 'package:feedback24_app/sign_up/sign_up_step3/bloc/sign_up_step3_bloc.dart';
import 'package:feedback24_app/sign_up/sign_up_step3/view/sign_up_step3_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class SignUpStep3Page extends StatelessWidget {
  const SignUpStep3Page({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const SignUpStep3Page(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: BlocProvider(
        create: (context) => SignUpStep3Bloc(
          checkoutBloc: context.read<CheckoutCubit>(),
          userRepository: context.read<UserRepository>(),
          authenticationBloc: context.read<AuthenticationBloc>(),
        ),
        child: const SignUpStep3Form(),
      ),
    );
  }
}
