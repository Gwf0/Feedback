import 'package:feedback24_app/gen/assets.gen.dart';
import 'package:feedback24_app/sign_up/checkout/cubit/checkout_cubit.dart';
import 'package:feedback24_app/sign_up/sign_up_step2/bloc/sign_up_step2_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SignUpStep2Form extends StatelessWidget {
  const SignUpStep2Form({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpStep2Bloc, SignUpStep2State>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Введенный смс код не верный!')),
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
          const SizedBox(height: 12.0),
          _PostcodeInput(),
          const SizedBox(height: 12.0),
          _SubmitButton(),
          const SizedBox(width: 8.0),
          _CancelButton(),
        ],
      )),
    );
  }
}

class _PostcodeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpStep2Bloc, SignUpStep2State>(
      buildWhen: (previous, current) => previous.code != current.code,
      builder: (context, state) {
        return TextFormField(
          key: const Key('SignUpStep2Form_postcodeInput_textField'),
          onChanged: (code) =>
              context.read<SignUpStep2Bloc>().add(PostcodeChanged(code)),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'Cмс',
            errorText: state.code.invalid ? state.code.error?.message : null,
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpStep2Bloc, SignUpStep2State>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          context.read<CheckoutCubit>().codeChanged(state.code.value);
          context.read<CheckoutCubit>().stepContinued();
        }
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: ElevatedButton(
                  key: const Key('SignUpStep2Form_submitButton_elevatedButton'),
                  style: ElevatedButton.styleFrom(elevation: 0),
                  onPressed: state.status.isValidated
                      ? () => context
                          .read<SignUpStep2Bloc>()
                          .add(FormStep2Submitted())
                      : null,
                  child: const Text('Далее'),
                ));
      },
    );
  }
}

class _CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpStep2Bloc, SignUpStep2State>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const SizedBox.shrink()
            : OutlinedButton(
                key: const Key('SignUpStep2Form_cancelButton_elevatedButton'),
                onPressed: () => context.read<CheckoutCubit>().stepCancelled(),
                child: const Text('Назад'),
              );
      },
    );
  }
}
