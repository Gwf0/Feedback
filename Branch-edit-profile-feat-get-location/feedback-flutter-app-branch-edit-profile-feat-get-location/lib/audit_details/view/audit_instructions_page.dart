import 'package:feedback24_app/audit_details/data/repository/audit_details_repository.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/audit_details_bloc.dart';

class CreateInstructions extends StatefulWidget {
  @override
  State<CreateInstructions> createState() => _CreateInstructionsState();
}

class _CreateInstructionsState extends State<CreateInstructions> {
  final AuditDetailsRepository auditDetailsRepository =
      new AuditDetailsRepository();
  final AuditInstructionsRepository auditInstructionsRepository =
      new AuditInstructionsRepository();
  final AuditShedulRepository auditShedulRepository =
      new AuditShedulRepository();
  Widget build(BuildContext context) {
    return BlocProvider<AuditDetailsBloc>(
        create: (context) => AuditDetailsBloc(
              auditShedulRepository: auditShedulRepository,
              auditDetailsRepository: auditDetailsRepository,
              auditInstructionsRepository: auditInstructionsRepository,
            )..add(AuditDetailsFetchEvent()),
        child: BlocBuilder<AuditDetailsBloc, AuditDetailsState>(
            builder: (context, state) {
          if (state is AuditDetailsLoading) {
            return Container(
                color: Colors.white,
                child: const Center(
                  child: CircularProgressIndicator(),
                ));
          }
          if (state is AuditDetailsError) {
            return Container(
                color: Colors.white, child: Center(child: Text(state.message)));
          }
          if (state is AuditDetailsLoaded) {
            return SafeArea(
                child: Scaffold(
                    appBar: AppBar(
                      title: const Text('Инструкция'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop('Instructions Agreed');
                            },
                            child: new Text('Соглашаюсь',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: Colors.white))),
                      ],
                    ),
                    body: SingleChildScrollView(
                        child: Container(
                            alignment: Alignment.center,
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ListTile(
                                  title: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15.0),
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Text(state.instructions.title),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 0.5, color: Colors.grey),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                      )),
                                  subtitle: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Html(
                                      data: state.instructions.contentHtml,
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.5, color: Colors.grey),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                  ),
                                ))))));
          }
          return Container();
        }));
  }
}
