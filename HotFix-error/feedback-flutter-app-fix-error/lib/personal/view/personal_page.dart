import 'package:feedback24_app/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:feedback24_app/personal/personal.dart';

class PersonalPage extends StatelessWidget {
  PersonalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PersonalBloc>(
      create: (context) => PersonalBloc(
        personalRepository: RepositoryProvider.of<PersonalRepository>(context),
      )..add(PersonalFetchEvent()),
      child: BlocBuilder<PersonalBloc, PersonalState>(
        builder: (context, state) {
          if (state is PersonalLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PersonalError) {
            return Center(child: Text(state.message));
          }
          if (state is PersonalLoaded) {
            return ListView(children: <Widget>[
              Column(
                children: [
                  buildPersonalItem(
                    title: 'Фамилия',
                    body: state.userPersonal.lastName!,
                  ),
                  buildPersonalItem(
                    title: 'Имя',
                    body: state.userPersonal.firstName!,
                  ),
                  buildPersonalItem(
                    title: 'Отчество',
                    body: state.userPersonal.middleName!,
                  ),
                  buildPersonalItem(
                    title: 'Номер телефона',
                    body: state.userPersonal.phone!,
                  ),
                  buildPersonalItem(
                    title: 'Адрес электронной почты',
                    body: state.userPersonal.email!,
                  ),
                  buildPersonalItem(
                    title: 'Пол',
                    body: state.userPersonal.sex!,
                  ),
                  buildPersonalItem(
                    title: 'Роль',
                    body: state.userPersonal.role!,
                  ),
                  buildPersonalItem(
                    title: 'Город',
                    body: state.userPersonal.city!.name!,
                  ),
                  buildPersonalItem(
                    title: 'Дата рождения',
                    body: state.userPersonal.formatedBirthDate,
                  ),
                  buildPersonalItem(
                    title: 'Инн',
                    body: state.userPersonal.inn?.toString() ?? '',
                  ),
                  buildPersonalItem(
                    title: 'Образование',
                    body: state.userPersonal.education!,
                  ),
                  buildPersonalItem(
                    title: 'Cфера деятельности',
                    body: state.userPersonal.activity!,
                  ),
                  buildPersonalItem(
                    title: 'О себе',
                    body: state.userPersonal.about ?? '',
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        top: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .add(
                                    LoggedOut(),
                                  );
                                },
                                child: Row(children: <Widget>[
                                  const Text('Выйти с аккаунта  '),
                                  Icon(Icons.logout),
                                ])),
                          )
                        ],
                      ))
                ],
              )
            ]);
          }
          return Container();
        },
      ),
    );
  }

  Widget buildPersonalItem({
    required String title,
    required String body,
  }) =>
      Padding(
          padding: EdgeInsets.only(
            left: 20,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              body,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Container(
                width: 350,
                height: 28,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  )),
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                    ]))
          ]));
}
