import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:feedback24_app/map/data/repository/placemark_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:location/location.dart' as loc;

import '../bloc/map_bloc.dart';

import '../bloc/map_bloc.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ClusterizedPlacemarkCollectionExample();
  }
}

class _ClusterizedPlacemarkCollectionExample extends StatefulWidget {
  @override
  _ClusterizedPlacemarkCollectionExampleState createState() =>
      _ClusterizedPlacemarkCollectionExampleState();
}

class _ClusterizedPlacemarkCollectionExampleState
    extends State<_ClusterizedPlacemarkCollectionExample> {
  late YandexMapController controller;
  final int kPlacemarkCount = 500;
  final Random seed = Random();
  final MapObjectId mapObjectId =
      MapObjectId('clusterized_placemark_collection');
  final MapObjectId largeMapObjectId =
      MapObjectId('large_clusterized_placemark_collection');
  final MapRepository mapRepository = new MapRepository();

  loc.Location location = loc.Location();

  Future _checkGps() async {
    if (!await location.serviceEnabled()) {
      location.requestService();
    }
  }

  @override
  void initState() {
    super.initState();
    _checkGps();
    Timer.run(() {
      try {
        InternetAddress.lookup('google.com').then((result) {
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            print('есть доступ');
          } else {
            _showDialog();
          }
        }).catchError((error) {
          _showDialog();
        });
      } on SocketException catch (_) {
        _showDialog();
        print('нет доступа');
      }
    });
  }

  void _showDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: SingleChildScrollView(
                child: ListBody(children: <Widget>[
              Icon(
                Icons.wifi_tethering_error_rounded,
                size: 100,
                color: Colors.red,
              ),
              Text(
                "Нет соединения с сетью",
                textAlign: TextAlign.center,
              ),
            ])),
            content: Text(
              "Ваш телефон без доступа к интернету. Пожалуйста выполните следующие пункты: \n " +
                  "\n 1. Подключитесь к сети интернет или включите мобильную передачу данных. \n" +
                  "\n 2. Перезайдите в приложение.",
              textAlign: TextAlign.start,
            ),
            actions: <Widget>[
              Row(children: <Widget>[
                Expanded(
                    child: Center(
                  child: ElevatedButton(
                      child: Text("Выйти"),
                      onPressed: () {
                        exit(0);
                      }),
                )),
                Expanded(
                    child: Center(
                  child: ElevatedButton(
                      child: Text("Обновить"),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                )),
              ])
            ],
          );
        });
  }

  Widget build(BuildContext context) {
    return BlocProvider<MapBloc>(
        create: (context) => MapBloc(
              mapRepository: mapRepository,
            )..add(MapFetchEvent()),
        child: BlocBuilder<MapBloc, MapState>(builder: (context, state) {
          if (state is MapLoading) {
            return Container(
                color: Colors.white,
                child: const Center(
                  child: CircularProgressIndicator(),
                ));
          }
          if (state is MapError) {
            return Container(
                color: Colors.white, child: Center(child: Text(state.message)));
          }
          if (state is MapLoaded) {
            return YandexMap(
                fastTapEnabled: true,
                mode2DEnabled: true,
                liteModeEnabled: true,
                onMapCreated: (YandexMapController mapController) async {
                  controller = mapController;
                  final List<MapObject> mapObjects = [];
                  final initialPoint = Point(
                    latitude: 45.052827,
                    longitude: 38.948185,
                  );

                  await mapController.moveCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: initialPoint,
                      zoom: 17,
                    ),
                  ));
                });
          }
          return Container();
        }));
  }
}
