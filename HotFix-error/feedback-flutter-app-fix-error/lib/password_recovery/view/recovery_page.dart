import 'package:feedback24_app/gen/assets.gen.dart';
import 'package:feedback24_app/password_recovery/bloc/recovery_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:user_repository/user_repository.dart';

class RecoveryPage extends StatefulWidget {
  const RecoveryPage({Key? key}) : super(key: key);

  @override
  State<RecoveryPage> createState() => _RecoveryState();
}

class _RecoveryState extends State<RecoveryPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailRecoveryController = TextEditingController();

  @override
  void dispose() {
    _emailRecoveryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RecoveryBloc>(
        create: (BuildContext context) => RecoveryBloc(
              userRepository: context.read<UserRepository>(),
            ),
        child: WillPopScope(
            onWillPop: () async => true,
            child: Scaffold(
              body: BlocListener<RecoveryBloc, RecoveryState>(
                listener: (context, state) {
                  if (state is AuthError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.error)));
                  }
                },
                child: BlocBuilder<RecoveryBloc, RecoveryState>(
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
                              "Восстановление пароля",
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
                                      keyboardType: TextInputType.emailAddress,
                                      controller: _emailRecoveryController,
                                      decoration: const InputDecoration(
                                        hintText: "Эл.почта",
                                        border: OutlineInputBorder(),
                                      ),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Введите адрес Эл.почты';
                                        }

                                        if (!RegExp(r'\S+@\S+\.\S+')
                                            .hasMatch(value)) {
                                          return "Введите правильный адрес";
                                        }

                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.65,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _authenticateWithEmail(context);
                                        },
                                        child: const Text('Далее'),
                                      ),
                                    ),
                                    OutlinedButton(
                                      onPressed: () =>
                                          context.goNamed('signin'),
                                      child: const Text('Назад'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 35),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            )));
  }

  void _authenticateWithEmail(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<RecoveryBloc>(context).add(
        RecoveryPass(_emailRecoveryController.text),
      );
    }
  }
}
