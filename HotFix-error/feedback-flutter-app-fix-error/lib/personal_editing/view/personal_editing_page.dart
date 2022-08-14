import 'package:feedback24_app/personal_editing/data/repository/personal_edit_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/presonal_editing_bloc.dart';

class PersonalEditPage extends StatefulWidget {
  const PersonalEditPage({Key? key}) : super(key: key);
  @override
  _PersonalEditPageState createState() => _PersonalEditPageState();
}

class _PersonalEditPageState extends State<PersonalEditPage> {
  final PersonalEditRepository personalEditRepository =
      new PersonalEditRepository();

  final _form1Key = GlobalKey<FormState>();
  final email = TextEditingController();
  final phone = TextEditingController();
  final inn = TextEditingController();
  final middleName = TextEditingController();
  final lastName = TextEditingController();
  final firstName = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    phone.dispose();
    inn.dispose();
    middleName.dispose();
    lastName.dispose();
    firstName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PresonalEditingBloc>(
        create: (context) => PresonalEditingBloc(
              personalEditRepository: personalEditRepository,
            )..add(PersonalEditFetchEvent()),
        child: BlocBuilder<PresonalEditingBloc, PresonalEditingState>(
            builder: (context, state) {
          if (state is PersonalEditingLoading) {
            return Container(
                color: Colors.white,
                child: const Center(
                  child: CircularProgressIndicator(),
                ));
          }
          if (state is PersonalEditingError) {
            return Container(
                color: Colors.white, child: Center(child: Text(state.message)));
          }
          if (state is PersonalEditingLoaded) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text('Редактировать Данные'),
                ),
                body: SingleChildScrollView(
                    key: _form1Key,
                    padding:
                        const EdgeInsets.only(top: 18, right: 12, left: 12),
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, left: 12, right: 12),
                                child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: lastName,
                                    decoration: InputDecoration(
                                      hintText: "Фамилия",
                                      labelText: state.personalEdit.lastName,
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      return value != null && value.length < 2
                                          ? "Введите корректную фамилию"
                                          : null;
                                    })),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.5, color: Colors.grey),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16))),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Container(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, left: 12, right: 12),
                                child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: firstName,
                                    decoration: InputDecoration(
                                      hintText: "Имя",
                                      labelText: state.personalEdit.firstName,
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      return value != null && value.length < 2
                                          ? "Введите корректное имя"
                                          : null;
                                    })),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.5, color: Colors.grey),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16))),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Container(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, left: 12, right: 12),
                                child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: middleName,
                                    decoration: InputDecoration(
                                      hintText: "Отчество",
                                      labelText: state.personalEdit.middleName,
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      return value != null && value.length < 2
                                          ? "Введите корректное отчество"
                                          : null;
                                    })),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.5, color: Colors.grey),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16))),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Container(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, left: 12, right: 12),
                                child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: email,
                                    decoration: InputDecoration(
                                      hintText: "E-Mail",
                                      labelText: state.personalEdit.email,
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
                                    })),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.5, color: Colors.grey),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16))),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Container(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, left: 12, right: 12),
                                child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    controller: phone,
                                    decoration: InputDecoration(
                                      hintText: "Номер",
                                      labelText: state.personalEdit.phone,
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      return value != null && value.length < 11
                                          ? "Введите корректный номер телефона"
                                          : null;
                                    })),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.5, color: Colors.grey),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16))),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Container(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, left: 12, right: 12),
                                child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    controller: inn,
                                    decoration: InputDecoration(
                                      hintText: "Инн",
                                      labelText:
                                          state.personalEdit.inn.toString(),
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      return value != null && value.length < 10
                                          ? "Введите корректный инн"
                                          : null;
                                    })),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.5, color: Colors.grey),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16))),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Container(
                              child: ElevatedButton(
                            onPressed: () {
                              _editPersonal(context);
                            },
                            child: const Text("Сохранить"),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ))),
                          )),
                          Container(
                              child: ElevatedButton(
                            onPressed: () {
                              context.goNamed('exit');
                            },
                            child: const Text("Назад"),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ))),
                          ))
                        ])));
          }

          return Container();
        }));
  }

  void _editPersonal(context) {
    if (_form1Key.currentState?.validate() ?? true) {
      BlocProvider.of<PresonalEditingBloc>(context).add(
        PersonalEditAddEvent(
            phone.toString(),
            email.toString(),
            lastName.toString(),
            middleName.toString(),
            firstName.toString(),
            inn.toString()),
      );
    }
  }
}
