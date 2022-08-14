import 'package:feedback24_app/sign_up/checkout/cubit/checkout_cubit.dart';
import 'package:feedback24_app/sign_up/checkout/view/checkout_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<CheckoutCubit>(
        create: (_) => CheckoutCubit(3),
        child: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: const CheckoutStepper(),
        ),
      ),
    );
  }
}
