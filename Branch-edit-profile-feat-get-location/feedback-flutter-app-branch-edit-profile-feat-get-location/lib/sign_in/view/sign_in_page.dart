import 'package:country_code_picker/country_code_picker.dart';
import 'package:feedback24_app/authentication/bloc/authentication_bloc.dart';
import 'package:feedback24_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:user_repository/user_repository.dart';

import '../bloc/sign_in_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInState();
}

class _SignInState extends State<SignInPage> {
  CountryCode _countryCode = CountryCode(code: 'Ru', dialCode: '+7');
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;
  late String password;

  @override
  // ignore: unused_element, override_on_non_overriding_member
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInBloc>(
        create: (BuildContext context) => SignInBloc(
            authenticationBloc: context.read<AuthenticationBloc>(),
            userRepository: context.read<UserRepository>()),
        child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              body: BlocListener<SignInBloc, SignInState>(
                listener: (context, state) {
                  if (state is AuthError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.error)));
                  }
                },
                child: BlocBuilder<SignInBloc, SignInState>(
                    builder: (context, state) {
                  if (state is Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: SingleChildScrollView(
                        reverse: true,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Assets.images.group.svg(
                              height: 48,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Войти",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            Center(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                        keyboardType: TextInputType.phone,
                                        controller: _phoneController,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.symmetric(vertical: 2),
                                          prefixIcon: CountryCodePicker(
                                            countryFilter: [
                                              'RU',
                                              'BY',
                                              'UA',
                                              'KZ'
                                            ],
                                            onChanged:
                                                (CountryCode countryCode) {
                                              setState(() {
                                                _countryCode = countryCode;
                                              });
                                            },
                                            flagDecoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            initialSelection: 'RU',
                                            showFlag: true,
                                            showCountryOnly: false,
                                            showOnlyCountryWhenClosed: false,
                                            alignLeft: false,
                                          ),
                                          hintText: "Телефон",
                                          border: OutlineInputBorder(),
                                        ),
                                        validator: (value) {
                                          return value != null &&
                                                  value.length < 10
                                              ? "Введите корректный номер телефона"
                                              : null;
                                        }),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.text,
                                      controller: _passwordController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Пароль",
                                      ),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (val) => val!.length < 6
                                          ? 'Слишком короткий пароль'
                                          : null,
                                      onSaved: (val) => password = val!,
                                      obscureText: _obscureText,
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.65,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _authenticateWithPhoneAndPassword(
                                              context);
                                        },
                                        child: const Text('Войти'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 35),
                            const Text("У вас нет аккаунта?"),
                            const SizedBox(height: 10),
                            OutlinedButton(
                              onPressed: () => context.pushNamed('signup'),
                              child: const Text("Регистрация"),
                            ),
                            TextButton(
                                onPressed: () => context.pushNamed('recovery'),
                                child: const Text("Восстановить пароль"),
                                style: TextButton.styleFrom(
                                  primary: Colors.red,
                                  textStyle: const TextStyle(fontSize: 12),
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            )));
  }

  void _authenticateWithPhoneAndPassword(context) {
    final phoneNumberWithCode = "${_countryCode.dialCode}";
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<SignInBloc>(context).add(
        SignInRequested(phoneNumberWithCode + _phoneController.text,
            _passwordController.text),
      );
    }
  }
}
