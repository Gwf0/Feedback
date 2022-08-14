import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          left: 20,
        ),
        child: Scaffold(
            body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Container(
                  child: Text(
                'Разрешения',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              )),
              const SizedBox(
                height: 3,
              ),
              Container(
                  child: Text(
                'для использования приложения',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              )),
              Container(
                  width: 350,
                  height: 15,
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    )),
                    shape: BoxShape.rectangle,
                  )),
              const SizedBox(
                height: 5,
              ),
              Container(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _checkPermissionLocation(context);
                        },
                        icon: const Icon(Icons.location_on),
                        label: const Text("Доступ к локации"),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ))),
                      ))),
              Container(
                  width: 350,
                  height: 7,
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    )),
                    shape: BoxShape.rectangle,
                  )),
              const SizedBox(
                height: 6,
              ),
              Container(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _checkPermissionCamera(context);
                        },
                        icon: const Icon(Icons.camera_enhance_rounded),
                        label: const Text("Доступ к камере"),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ))),
                      ))),
              const SizedBox(
                height: 5,
              ),
              Container(
                  decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color: Colors.grey,
                  width: 1,
                )),
                shape: BoxShape.rectangle,
              )),
              const SizedBox(
                height: 5,
              ),
              Container(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _checkPermissionMicro(context);
                        },
                        icon: const Icon(Icons.mic_rounded),
                        label: const Text("Доступ к микрофону"),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ))),
                      ))),
              const SizedBox(
                height: 5,
              ),
              Container(
                  decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color: Colors.grey,
                  width: 1,
                )),
                shape: BoxShape.rectangle,
              )),
              const SizedBox(
                height: 5,
              ),
              Container(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _checkPermissionStorage(context);
                        },
                        icon: const Icon(Icons.file_copy_outlined),
                        label: const Text("Доступ к файлам"),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ))),
                      ))),
              const SizedBox(
                height: 5,
              ),
              Container(
                  decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color: Colors.grey,
                  width: 1,
                )),
                shape: BoxShape.rectangle,
              )),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        )));
  }

  void _checkPermissionCamera(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    Map<Permission, PermissionStatus> statues = await [
      Permission.camera,
    ].request();
    PermissionStatus? statusCamera = statues[Permission.camera];

    bool isGranted = statusCamera == PermissionStatus.granted;

    if (isGranted) {}
    bool isPermanentlyDenied =
        statusCamera == PermissionStatus.permanentlyDenied;
    if (isPermanentlyDenied) {}
  }

  void _checkPermissionLocation(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    Map<Permission, PermissionStatus> statues = await [
      Permission.location,
    ].request();
    PermissionStatus? statuslocation = statues[Permission.location];

    bool isGranted1 = statuslocation == PermissionStatus.granted;

    if (isGranted1) {}
    bool isPermanentlyDenied1 =
        statuslocation == PermissionStatus.permanentlyDenied;
    if (isPermanentlyDenied1) {}
  }

  void _checkPermissionStorage(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    Map<Permission, PermissionStatus> statues = await [
      Permission.storage,
    ].request();
    PermissionStatus? statusStorage = statues[Permission.storage];
    bool isGranted = statusStorage == PermissionStatus.granted;

    if (isGranted) {}

    bool isPermanentlyDenied =
        statusStorage == PermissionStatus.permanentlyDenied;
    if (isPermanentlyDenied) {}
  }

  void _checkPermissionMicro(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    Map<Permission, PermissionStatus> statues = await [
      Permission.microphone,
    ].request();
    PermissionStatus? statusmicrophone = statues[Permission.microphone];
    bool isGranted = statusmicrophone == PermissionStatus.granted;

    if (isGranted) {}

    bool isPermanentlyDenied =
        statusmicrophone == PermissionStatus.permanentlyDenied;
    if (isPermanentlyDenied) {}
  }
}
