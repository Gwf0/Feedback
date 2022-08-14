import 'package:feedback24_app/audit_details/data/model/audit_details_model.dart';
import 'package:feedback24_app/audit_details/data/repository/audit_details_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/audit_details_bloc.dart';

class CreateCheklist extends StatefulWidget {
  @override
  State<CreateCheklist> createState() => _CreateCheklistState();
}

class _CreateCheklistState extends State<CreateCheklist> {
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
                      title: const Text('Чек-лист'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop('Cheklist Agreed');
                            },
                            child: new Text('Соглашаюсь',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: Colors.white))),
                      ],
                    ),
                    body: SizedBox(
                        height: 10000,
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: <
                                Widget>[
                          Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: 1,
                                  addSemanticIndexes: true,
                                  addRepaintBoundaries: true,
                                  addAutomaticKeepAlives: true,
                                  itemBuilder: (context, index) {
                                    return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 10,
                                                    left: 10,
                                                    right: 10,
                                                  ),
                                                  child: ListTile(
                                                    title: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 10.0),
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Text(state
                                                              .auditDetails
                                                              .checklistElement
                                                              .title),
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  width: 0.5,
                                                                  color: Colors
                                                                      .grey),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          10))),
                                                        )),
                                                  ))),
                                          ListView.builder(
                                            itemCount: state.auditDetails
                                                .checklistElement.score,
                                            physics: ClampingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return _buildAuditItem(
                                                checklistElement: state
                                                    .auditDetails
                                                    .checklistElement
                                                    .children[index],
                                                context: context,
                                              );
                                            },
                                          ),
                                        ]);
                                  }))
                        ]))));
          }
          return Container();
        }));
  }

  Widget _buildAuditItem(
      {required ChecklistElement checklistElement,
      required BuildContext context}) {
    return Container(
        alignment: Alignment.center,
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              title: Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(checklistElement.title),
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                  )),
              subtitle: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  checklistElement.artifacts.toString(),
                ),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
              ),
              leading: Container(
                decoration: BoxDecoration(
                  border: Border(),
                ),
                child: Icon(
                  Icons.quiz_outlined,
                  color: Colors.red,
                ),
              ),
            )));
  }
}
