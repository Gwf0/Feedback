import 'dart:math';

import 'package:feedback24_app/audit_details/data/repository/audit_details_repository.dart';
import 'package:feedback24_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'audit_cheklist_page.dart' as fullDialog;
import 'package:feedback24_app/quiz/view/quiz_page.dart' as fullDialog;

import '../bloc/audit_details_bloc.dart';
import 'audit_instructions_page.dart' as fullDialog;
import 'package:intl/intl.dart';

class AuditDetailsPage extends StatefulWidget {
  final String auditId;

  const AuditDetailsPage({Key? key, required this.auditId}) : super(key: key);
  @override
  State<AuditDetailsPage> createState() => _AuditDetailsState();
}

class _AuditDetailsState extends State<AuditDetailsPage> {
  final AuditDetailsRepository auditDetailsRepository =
      new AuditDetailsRepository();
  final AuditInstructionsRepository auditInstructionsRepository =
      new AuditInstructionsRepository();
  final AuditShedulRepository auditShedulRepository =
      new AuditShedulRepository();
  final List<MapObject> mapObjects = [];
  final MapObjectId placemarkId = const MapObjectId('normal_icon_placemark');
  final int kPlacemarkCount = 500;
  final Random seed = Random();
  final MapObjectId mapObjectId =
      MapObjectId('clusterized_placemark_collection');
  final MapObjectId largeMapObjectId =
      MapObjectId('large_clusterized_placemark_collection');
  final TextEditingController dateinput = TextEditingController();

  @override
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
            return Scaffold(
                appBar: AppBar(
                  title: Text(widget.auditId),
                ),
                body: ListView(children: <Widget>[
                  SizedBox(
                      height: 1400,
                      child: Column(children: [
                        Expanded(
                            child: Container(
                                padding: const EdgeInsets.only(
                                    left: 5, top: 5, right: 5, bottom: 5),
                                child: YandexMap(
                                    fastTapEnabled: true,
                                    mode2DEnabled: true,
                                    liteModeEnabled: true,
                                    onMapCreated: (YandexMapController
                                        mapController) async {
                                      final initialPoint = PlacemarkMapObject(
                                          mapId: mapObjectId,
                                          point: Point(
                                              latitude: 45.432665650000004,
                                              longitude: 40.55587935),
                                          icon: PlacemarkIcon.single(
                                              PlacemarkIconStyle(
                                                  image: BitmapDescriptor
                                                      .fromAssetImage(Assets
                                                          .images.group
                                                          .svg(height: 10)
                                                          .toString()),
                                                  rotationType:
                                                      RotationType.rotate)));
                                      await mapController.moveCamera(
                                          CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                          target: initialPoint.point,
                                          zoom: 17,
                                        ),
                                      ));
                                    }))),
                        Card(
                            child: ListTile(
                          title: Text('Номер проверки:'),
                          subtitle: Text(state.auditDetails.id.toString()),
                          leading: Icon(Icons.security_update_good),
                          iconColor: Colors.red,
                        )),
                        Card(
                            child: ListTile(
                          title:
                              Text(state.auditDetails.entity.name.toString()),
                          subtitle: Text(
                              state.auditDetails.entity.address.toString()),
                          leading: Icon(Icons.location_city_rounded),
                          iconColor: Colors.red,
                        )),
                        Card(
                          child: ListTile(
                            title: Text('Тип проверки:'),
                            subtitle: Text(state.auditDetails.type),
                            leading: Icon(Icons.warning_amber_outlined),
                            iconColor: Colors.red,
                          ),
                        ),
                        Card(
                            child: ListTile(
                          title: Text('Дата публикации:'),
                          subtitle: Text(state.auditDetails.formatedPublishedAt
                              .toString()),
                          leading: Icon(Icons.insert_invitation_outlined),
                          iconColor: Colors.red,
                        )),
                        Card(
                            child: ListTile(
                          title: Text('Дата проведения проверки:'),
                          subtitle: Text(state
                              .auditDetails.formatedExpirationDate
                              .toString()),
                          leading: Icon(Icons.insert_invitation),
                          iconColor: Colors.red,
                        )),
                        Card(
                            child: ListTile(
                          title: Text('Оплата:'),
                          subtitle:
                              Text(state.auditDetails.rewardAmount.toString()),
                          leading: Icon(Icons.payments_outlined),
                          iconColor: Colors.red,
                        )),
                        Card(
                            child: ListTile(
                          title: Text('Возмещение:'),
                          subtitle:
                              Text(state.auditDetails.refundAmount.toString()),
                          leading: Icon(Icons.payments),
                          iconColor: Colors.red,
                        )),
                        Card(
                            child: ListTile(
                          title: Text("Пол: "),
                          subtitle:
                              Text(state.auditDetails.doerRequirements.sex),
                          leading: Icon(Icons.man),
                          iconColor: Colors.red,
                        )),
                        Card(
                            child: ListTile(
                          title: Text("Образование: "),
                          subtitle: Text(
                              state.auditDetails.doerRequirements.education),
                          leading: Icon(Icons.edit_outlined),
                          iconColor: Colors.red,
                        )),
                        Card(
                            child: ListTile(
                          title: Text("Возраст: "),
                          subtitle: Text(state.auditDetails.doerRequirements.age
                                  .toString() +
                              ' - 60'),
                          leading: Icon(Icons.accessibility_new_sharp),
                          iconColor: Colors.red,
                        )),
                        Card(
                            child: ListTile(
                          title: Text("Колличество откликов: "),
                          subtitle: Text('5'),
                          leading: Icon(Icons.people_alt_outlined),
                          iconColor: Colors.red,
                        )),
                        Card(
                            child: ListTile(
                          title: Text("Чек-лист"),
                          onTap: () => _openChecklistDialog(context),
                          leading: Icon(Icons.checklist),
                          iconColor: Colors.red,
                          textColor: Colors.red,
                        )),
                        Card(
                            child: ListTile(
                          title: Text("Инструкция"),
                          onTap: () => _openInstructionsDialog(context),
                          leading:
                              Icon(Icons.integration_instructions_outlined),
                          iconColor: Colors.red,
                          textColor: Colors.red,
                        )),
                        Card(
                            child: ListTile(
                          title: Text("Отчет"),
                          onTap: () => _openQuiz(context),
                          leading: Icon(Icons.question_answer),
                          iconColor: Colors.red,
                          textColor: Colors.red,
                        )),
                        Card(
                            child: ListTile(
                                title: TextFormField(
                          style: TextStyle(color: Colors.red),
                          controller: dateinput,
                          cursorColor: Colors.red,
                          decoration: InputDecoration(
                            iconColor: Colors.red,
                            border: InputBorder.none,
                            icon: Icon(Icons.calendar_today),
                            contentPadding:
                                new EdgeInsets.fromLTRB(15, 5, 5, 5),
                            labelText: "Выберите дату",
                          ),
                          validator: (value) {
                            return value != null && value.length < 1
                                ? "Введите дату"
                                : null;
                          },
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(state.schedule.dates.length),
                              lastDate: DateTime(2101),
                            );

                            if (pickedDate != null) {
                              print(pickedDate);
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(formattedDate);

                              setState(() {
                                dateinput.text = formattedDate;
                              });
                            } else {
                              print("Дата не выбрана");
                            }
                          },
                        ))),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0),
                                      onPressed: () {
                                        _postAudit(context);
                                      },
                                      child: const Text('Оставить заявку'),
                                    )))
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ]))
                ]));
          }
          return Container();
        }));
  }

  void _postAudit(context) {
    BlocProvider.of<AuditDetailsBloc>(context).add(
      AuditDetailsSend(dateinput.text),
    );
  }

  Future _openChecklistDialog(context) async {
    var result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) {
          return fullDialog.CreateCheklist();
        },
        fullscreenDialog: true));
    if (result != null) {
      letsDoSomethingChecklist(result, context);
    } else {
      print('cancel');
    }
  }

  letsDoSomethingChecklist(String result, context) {
    print(result);
  }

  Future _openQuiz(context) async {
    var result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) {
          return fullDialog.QuizPage();
        },
        fullscreenDialog: true));
    if (result != null) {
      letsDoSomethingQuiz(result, context);
    } else {
      print('cancel');
    }
  }

  letsDoSomethingQuiz(String result, context) {
    print(result);
  }

  Future _openInstructionsDialog(context) async {
    var result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) {
          return fullDialog.CreateInstructions();
        },
        fullscreenDialog: true));
    if (result != null) {
      letsDoSomethingInstructions(result, context);
    } else {
      print('cancel');
    }
  }

  letsDoSomethingInstructions(String result, context) {
    print(result);
  }
}
