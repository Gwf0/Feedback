import 'package:feedback24_app/sign_up/checkout/checkout.dart';
import 'package:feedback24_app/sign_up/sign_up_step2/view/sign_up_step2_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

import '../bloc/sign_up_step2_bloc.dart';

class SignUpStep2Page extends StatelessWidget {
  const SignUpStep2Page({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const SignUpStep2Page(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: BlocProvider(
        create: (context) => SignUpStep2Bloc(
          checkoutBloc: context.read<CheckoutCubit>(),
          userRepository: context.read<UserRepository>(),
        ),
        child: const SignUpStep2Form(),
      ),
    );
  }
}
