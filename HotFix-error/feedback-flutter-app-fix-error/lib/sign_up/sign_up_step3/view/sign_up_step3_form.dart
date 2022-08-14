import 'package:feedback24_app/gen/assets.gen.dart';
import 'package:feedback24_app/sign_up/checkout/cubit/checkout_cubit.dart';
import 'package:feedback24_app/sign_up/sign_up_step3/bloc/sign_up_step3_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SignUpStep3Form extends StatelessWidget {
  const SignUpStep3Form({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpStep3Bloc, SignUpStep3State>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  content:
                      Text('Ошибка ввода пароля или пароли не совпадают!')),
            );
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Assets.images.group.svg(
              height: 48,
            ),
            const SizedBox(
              height: 30,
            ),
            _Pass1Input(),
            const SizedBox(height: 12.0),
            _Pass2Input(),
            const SizedBox(height: 12.0),
            _SubmitButton(),
            const SizedBox(width: 8.0),
            _CancelButton(),
          ],
        ),
      ),
    );
  }
}

class _Pass1Input extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpStep3Bloc, SignUpStep3State>(
      buildWhen: (previous, current) => previous.pass1 != current.pass1,
      builder: (context, state) {
        return TextFormField(
          key: const Key('SignUpStep3Form_Pass1Input_textField'),
          onChanged: (pass1) =>
              context.read<SignUpStep3Bloc>().add(Pass1Changed(pass1)),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'Пароль',
            errorText: state.pass1.invalid ? state.pass1.error?.message : null,
          ),
        );
      },
    );
  }
}

class _Pass2Input extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpStep3Bloc, SignUpStep3State>(
      buildWhen: (previous, current) => previous.pass2 != current.pass2,
      builder: (context, state) {
        return TextFormField(
          key: const Key('SignUpStep3Form_Pass2Input_textField'),
          onChanged: (pass2) =>
              context.read<SignUpStep3Bloc>().add(Pass2Changed(pass2)),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'Повторите пароль',
            errorText: state.pass2.invalid ? state.pass2.error?.message : null,
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpStep3Bloc, SignUpStep3State>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess)
          print(state.status.isSubmissionSuccess);
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status.isSubmissionInProgress) {
          return const CircularProgressIndicator();
        } else {
          return SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: ElevatedButton(
                key: const Key('SignUpStep3Form_submitButton_elevatedButton'),
                style: ElevatedButton.styleFrom(elevation: 0),
                onPressed: state.status.isValidated
                    ? () => context
                        .read<SignUpStep3Bloc>()
                        .add(FormStep3Submitted())
                    : null,
                child: const Text('Далее'),
              ));
        }
      },
    );
  }
}

class _CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpStep3Bloc, SignUpStep3State>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const SizedBox.shrink()
            : OutlinedButton(
                key: const Key('SignUpStep3Form_cancelButton_elevatedButton'),
                onPressed: () => context.read<CheckoutCubit>().stepCancelled(),
                child: const Text('Назад'),
              );
      },
    );
  }
}
