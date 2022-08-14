import 'package:feedback24_app/audits/bloc/audits_bloc.dart';
import 'package:feedback24_app/audits/data/model/audit_model.dart';
import 'package:feedback24_app/audits/data/repository/audit_repository.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:go_router/go_router.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AuditsPage extends StatefulWidget {
  AuditsPage({Key? key}) : super(key: key);

  @override
  State<AuditsPage> createState() => _AuditsPageState();
}

class _AuditsPageState extends State<AuditsPage> {
  final AuditRepository auditRepository = new AuditRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuditsBloc>(
        create: (context) => AuditsBloc(
              auditRepository: auditRepository,
            )..add(AuditsFetchEvent()),
        child: BlocBuilder<AuditsBloc, AuditsState>(builder: (context, state) {
          if (state is AuditsLoading) {
            return Container(
                color: Colors.white,
                child: const Center(
                  child: CircularProgressIndicator(),
                ));
          }
          if (state is AuditsError) {
            return Container(
                color: Colors.white, child: Center(child: Text(state.message)));
          }
          if (state is AuditsLoaded) {
            return DefaultTabController(
                length: 2,
                child: Scaffold(
                    appBar: AppBar(
                      title: const Text('Проверки'),
                      actions: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(right: 20.0),
                            child: GestureDetector(
                                child: Icon(
                                  Icons.filter_alt_sharp,
                                  size: 26.0,
                                ),
                                onTap: () => _showBottomSheetFilter(context)))
                      ],
                      bottom: TabBar(
                        tabs: [
                          Tab(text: 'Новые проверки'),
                          Tab(text: 'Мои проверки'),
                        ],
                        //onTap: (index) => _tap(context, index),
                      ),
                    ),
                    body: TabBarView(
                      children: [
                        SafeArea(
                          child: RefreshIndicator(
                              triggerMode: RefreshIndicatorTriggerMode.anywhere,
                              edgeOffset: 0,
                              onRefresh: () async {
                                BlocProvider.of<AuditsBloc>(context)
                                    .add(AuditsFetchEvent());
                                return Future<void>.delayed(
                                    const Duration(seconds: 1));
                              },
                              child: ListView.builder(
                                itemCount: state.auditList.total,
                                itemBuilder: (context, index) {
                                  return _buildAuditItem(
                                    audit: state.auditList.audits[index],
                                    context: context,
                                  );
                                },
                              )),
                        ),
                        Center(child: Text('Мои проверки')),
                      ],
                    )));
          }
          return Container();
        }));
  }

  void _showBottomSheetFilter(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.50,
          maxChildSize: 1,
          minChildSize: 0.50,
          expand: true,
          builder: (context, scrollController) {
            return Container(
              height: 200,
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ElevatedButton(
                      child: const Text('Закрыть'),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

Widget _buildAuditItem({required Audit audit, required BuildContext context}) {
  return Card(
      child: Container(
          child: ListTile(
              title: Container(
                padding: EdgeInsets.only(top: 3, bottom: 10, right: 3, left: 3),
                child: Text(audit.type.toString() + '\n' + audit.entity.name),
              ),
              subtitle: Container(
                padding: EdgeInsets.only(top: 3, bottom: 10, right: 3, left: 3),
                child: Text(audit.entity.address +
                    '\n' +
                    '\n' +
                    'Оплата: ' +
                    audit.rewardAmount.toString() +
                    ' руб' +
                    '\n' +
                    '\n' +
                    'Период: с ' +
                    audit.formatedPublishedAt +
                    ' по ' +
                    audit.formatedExpirationDate),
              ),
              leading: Container(
                  decoration: new BoxDecoration(
                      border: new Border(
                    right: new BorderSide(
                      width: 2,
                      color: Colors.grey,
                      style: BorderStyle.solid,
                    ),
                  )),
                  child: Icon(Icons.playlist_add_check_circle_outlined)),
              onTap: () {
                context.goNamed('details', params: {'auditId': '5643'});
              })));
}
 /*String setType() {
    if ( == 'visit') {
      return ('Визит');
    }
    if ( == 'complex') {
      return ('Комплексная проверка');
    }
    if ( == 'call') {
      return ('Звонок');
    } else {
      return ('');
    }
  }*/



