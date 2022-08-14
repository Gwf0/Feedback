import 'package:country_code_picker/country_code_picker.dart';
import 'package:feedback24_app/gen/assets.gen.dart';
import 'package:feedback24_app/sign_up/checkout/cubit/checkout_cubit.dart';
import 'package:feedback24_app/sign_up/sign_up_step1/bloc/sign_up_step1_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'user_agreement.dart' as fullDialog;

class SignUpStep1Form extends StatelessWidget {
  const SignUpStep1Form({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpStep1Bloc, SignUpStep1State>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                    content: Text(
                        'Ошибка ввода данных или такой пользователь уже зарегистрирован!')),
              );
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Assets.images.group.svg(
                  height: 48,
                ),
                const SizedBox(
                  height: 30,
                ),
                _FirstnameInput(),
                const SizedBox(height: 12.0),
                _LastnameInput(),
                const SizedBox(height: 12.0),
                PhoneNumberInput(),
                const SizedBox(height: 12.0),
                _SubmitButton(),
                const SizedBox(width: 8.0, height: 20.0),
                _Text(),
                const SizedBox(),
                _UserAgreementButton(),
                const SizedBox(width: 8.0),
                _CancelButton(),
                const SizedBox(width: 8.0),
              ],
            ),
          ),
        ));
  }
}

class _FirstnameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpStep1Bloc, SignUpStep1State>(
      buildWhen: (previous, current) => previous.firstname != current.firstname,
      builder: (context, state) {
        return TextFormField(
          key: const Key('SignUpStep1Form_firstnameInput_textField'),
          onChanged: (firstname) =>
              context.read<SignUpStep1Bloc>().add(FirstnameChanged(firstname)),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'Имя',
            errorText:
                state.firstname.invalid ? state.firstname.error?.message : null,
          ),
        );
      },
    );
  }
}

class _LastnameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpStep1Bloc, SignUpStep1State>(
      buildWhen: (previous, current) => previous.lastname != current.lastname,
      builder: (context, state) {
        return TextFormField(
          key: const Key('SignUpStep1Form_lastnameInput_textField'),
          onChanged: (lastname) =>
              context.read<SignUpStep1Bloc>().add(LastnameChanged(lastname)),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'Фамилия',
            errorText:
                state.lastname.invalid ? state.lastname.error?.message : null,
          ),
        );
      },
    );
  }
}

class PhoneNumberInput extends StatefulWidget {
  @override
  State<PhoneNumberInput> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  // ignore: unused_field
  CountryCode _countryCode = CountryCode(code: 'Ru', dialCode: '+7');
  String _phoneNumber = '';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpStep1Bloc, SignUpStep1State>(
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: (context, state) {
        return TextFormField(
          key: const Key('SignUpStep1Form_phoneNumberInput_textField'),
          onChanged: (phoneNumber) {
            setState(() {
              _phoneNumber = phoneNumber;
            });
            final phoneCode = _countryCode.dialCode!.replaceAll('+', '');
            context
                .read<SignUpStep1Bloc>()
                .add(PhoneChanged('$phoneCode$phoneNumber'));
          },
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            prefixIcon: CountryCodePicker(
              countryFilter: ['RU', 'BY', 'UA', 'KZ'],
              onChanged: (CountryCode countryCode) {
                setState(() {
                  _countryCode = countryCode;
                });
                final String phoneCode =
                    _countryCode.dialCode!.replaceAll('+', '');
                context
                    .read<SignUpStep1Bloc>()
                    .add(PhoneChanged('$phoneCode$_phoneNumber'));
              },
              flagDecoration:
                  BoxDecoration(border: Border.all(color: Colors.grey)),
              initialSelection: 'RU',
              showFlag: true,
              showCountryOnly: false,
              showOnlyCountryWhenClosed: false,
              alignLeft: false,
            ),
            border: const OutlineInputBorder(),
            hintText: 'Номер телефона',
            errorText: state.phone.invalid ? state.phone.error?.message : null,
          ),
        );
      },
    );
  }
}

class _UserAgreementButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpStep1Bloc, SignUpStep1State>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const SizedBox.shrink()
            : TextButton(
                key: const Key('SignUpStep1Form_cancelButton_elevatedButton'),
                onPressed: () => _openAgreeDialog(context),
                child: const Text('Пользовательское соглашение'),
                style: TextButton.styleFrom(
                  maximumSize: Size(200, 40),
                  primary: Colors.red,
                  textStyle: const TextStyle(fontSize: 12),
                ));
      },
    );
  }
}

class _Text extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpStep1Bloc, SignUpStep1State>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const SizedBox.shrink()
            : Center(
                child: Text(
                "Нажимая кнопку далее вы принимаете",
              ));
      },
    );
  }
}

Future _openAgreeDialog(context) async {
  var result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        return fullDialog.CreateAgreement();
      },
      fullscreenDialog: true));
  if (result != null) {
    letsDoSomething(result, context);
  } else {
    print('you could do another action here if they cancel');
  }
}

letsDoSomething(String result, context) {
  print(result);
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpStep1Bloc, SignUpStep1State>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          context.read<CheckoutCubit>().stepContinued();
          context.read<CheckoutCubit>().phoneChanged(state.phone.value);
        }
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: ElevatedButton(
                  key: const Key('SignUpStep1Form_submitButton_elevatedButton'),
                  style: ElevatedButton.styleFrom(elevation: 0),
                  onPressed: state.status.isValidated
                      ? () => context
                          .read<SignUpStep1Bloc>()
                          .add(FormStep1Submitted())
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
    return BlocBuilder<SignUpStep1Bloc, SignUpStep1State>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const SizedBox.shrink()
            : OutlinedButton(
                key: const Key('SignUpStep1Form_cancelButton_elevatedButton'),
                onPressed: () => context.goNamed('signin'),
                child: const Text('Назад'),
              );
      },
    );
  }
}
