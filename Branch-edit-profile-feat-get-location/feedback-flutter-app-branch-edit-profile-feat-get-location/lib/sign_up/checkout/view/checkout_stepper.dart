import 'package:feedback24_app/sign_up/checkout/cubit/checkout_cubit.dart';
import 'package:feedback24_app/sign_up/sign_up_step1/view/sign_up_step1_page.dart';
import 'package:feedback24_app/sign_up/sign_up_step2/view/sign_up_step2_page.dart';
import 'package:feedback24_app/sign_up/sign_up_step3/view/sign_up_step3_page.dart';
import 'package:feedback24_app/sign_up/sign_up_step3/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutStepper extends StatelessWidget {
  const CheckoutStepper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        return Stepper(
          type: StepperType.horizontal,
          currentStep: state.activeStepperIndex,
          onStepTapped: context.read<CheckoutCubit>().stepTapped,
          controlsBuilder: (context, controlDetails) {
            return const SizedBox.shrink();
          },
          steps: [
            Step(
              title: const Text('Шаг 1'),
              content: const SignUpStep1Page(),
              isActive: state.activeStepperIndex >= 0,
              state: state.activeStepperIndex >= 0
                  ? StepState.complete
                  : StepState.disabled,
            ),
            Step(
              title: const Text('Шаг 2'),
              content: const SignUpStep2Page(),
              isActive: state.activeStepperIndex >= 1,
              state: state.activeStepperIndex >= 1
                  ? StepState.complete
                  : StepState.disabled,
            ),
            Step(
              title: const Text('Шаг 3'),
              content: const SignUpStep3Page(),
              isActive: state.activeStepperIndex >= 2,
              state: state.activeStepperIndex >= 2
                  ? StepState.complete
                  : StepState.disabled,
            ),
          ],
        );
      },
    );
  }
}
