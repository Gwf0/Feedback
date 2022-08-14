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
  final male = TextEditingController();
  final city = TextEditingController();
  final about = TextEditingController();
  final activity = TextEditingController();
  final education = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    phone.dispose();
    inn.dispose();
    middleName.dispose();
    lastName.dispose();
    firstName.dispose();
    male.dispose();
    city.dispose();
    about.dispose();
    activity.dispose();
    education.dispose();
    super.dispose();
  }

  final TextEditingController controlleraboutlength = TextEditingController();
  final maxLength = 100;

  @override
  void initState() {
    controlleraboutlength.addListener(() {
      setState(() {});
    });
    super.initState();
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
            String setSex() {
              if (state.personalEdit.sex == 'male') {
                return ('Мужской');
              }
              if (state.personalEdit.sex == 'female') {
                return ('Женский');
              } else {
                return ('');
              }
            }

            String setEducation() {
              if (state.personalEdit.education == 'higher') {
                return ('Высшее образование');
              }
              if (state.personalEdit.education == 'secondary') {
                return ('Комплексная проверка');
              }
              if (state.personalEdit.education == 'post_secondary') {
                return ('среднее общее образование');
              } else {
                return ('');
              }
            }

            return Scaffold(
                body: SingleChildScrollView(
                    padding:
                        const EdgeInsets.only(top: 18, right: 12, left: 12),
                    child: Form(
                        key: _form1Key,
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
                                          labelText:
                                              state.personalEdit.lastName,
                                        ),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          return value != null &&
                                                  value.length < 2
                                              ? "Введите корректную фамилию"
                                              : null;
                                        })),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Colors.grey),
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
                                          labelText:
                                              state.personalEdit.firstName,
                                        ),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          return value != null &&
                                                  value.length < 2
                                              ? "Введите корректное имя"
                                              : null;
                                        })),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Colors.grey),
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
                                          labelText:
                                              state.personalEdit.middleName,
                                        ),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          return value != null &&
                                                  value.length < 2
                                              ? "Введите корректное отчество"
                                              : null;
                                        })),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Colors.grey),
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
                                        keyboardType:
                                            TextInputType.emailAddress,
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
                                    border: Border.all(
                                        width: 0.5, color: Colors.grey),
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
                                        maxLength: 11,
                                        keyboardType: TextInputType.phone,
                                        controller: phone,
                                        decoration: InputDecoration(
                                          hintText: "Номер",
                                          labelText: state.personalEdit.phone,
                                        ),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          return value != null &&
                                                  value.length < 11
                                              ? "Введите корректный номер телефона"
                                              : null;
                                        })),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Colors.grey),
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
                                        maxLength: 12,
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
                                          return value != null &&
                                                  value.length < 12
                                              ? "Введите корректный инн"
                                              : null;
                                        })),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Colors.grey),
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
                                        controller: city,
                                        decoration: InputDecoration(
                                          hintText: "Город",
                                          labelText:
                                              state.personalEdit.city!.name,
                                        ),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          return value != null &&
                                                  value.length < 2
                                              ? "Введите корректный город"
                                              : null;
                                        })),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Colors.grey),
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
                                        controller: male,
                                        decoration: InputDecoration(
                                          hintText: "Пол",
                                          labelText: setSex(),
                                        ),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          return value != null &&
                                                  value.length < 4
                                              ? "Введите корректный пол"
                                              : null;
                                        })),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Colors.grey),
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
                                        controller: education,
                                        decoration: InputDecoration(
                                          hintText: "Образование",
                                          labelText: setEducation(),
                                        ),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return null;
                                          } else {
                                            return value != null &&
                                                    value.length < 2
                                                ? "Введите корректный данные"
                                                : null;
                                          }
                                        })),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Colors.grey),
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
                                      maxLength: 100,
                                      keyboardType: TextInputType.text,
                                      controller: about,
                                      decoration: InputDecoration(
                                        hintText: "О себе",
                                        labelText: state.personalEdit.about,
                                      ),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return null;
                                        } else {
                                          return value != null &&
                                                  value.length < 10
                                              ? "Введите  данные"
                                              : null;
                                        }
                                      },
                                      maxLines: 8,
                                      minLines: 1,
                                    )),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Colors.grey),
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
                                        controller: activity,
                                        decoration: InputDecoration(
                                          hintText: "Сфера дейтельности",
                                          labelText:
                                              state.personalEdit.activity,
                                        ),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return null;
                                          } else {
                                            return value != null &&
                                                    value.length < 5
                                                ? "Введите корректный данные"
                                                : null;
                                          }
                                        })),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Colors.grey),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16))),
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                              Center(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 12),
                                                  child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.65,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          _editPersonal(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            "Сохранить"),
                                                        style: ButtonStyle(
                                                            shape: MaterialStateProperty.all<
                                                                    RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30.0),
                                                        ))),
                                                      )))),
                                          const SizedBox(
                                            width: 25.0,
                                          ),
                                          Container(
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 12),
                                                  child: OutlinedButton(
                                                    onPressed: () {
                                                      context.goNamed('exit');
                                                    },
                                                    child: const Text("Назад"),
                                                    style: ButtonStyle(
                                                        shape: MaterialStateProperty.all<
                                                                RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                    ))),
                                                  ))),
                                          const SizedBox(
                                            height: 12.0,
                                          ),
                                        ])
                                  ]))
                            ]))));
          }
          return Container();
        }));
  }

  void _editPersonal(context) {
    if (_form1Key.currentState!.validate()) {
      BlocProvider.of<PresonalEditingBloc>(context).add(
        PersonalEditAddEvent(
          phone.text,
          email.text,
          lastName.text,
          middleName.text,
          firstName.text,
          inn.text as int,
          male.text,
          city.text,
          about.text,
          activity.text,
          education.text,
        ),
      );
    }
  }
}
