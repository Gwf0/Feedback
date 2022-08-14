import 'package:feedback24_app/payment/payment.dart';
import 'package:feedback24_app/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../personal/personal.dart';

class ProfilePage extends StatefulWidget {
  final int index;

  ProfilePage({String? tab, Key? key})
      : index = indexFrom(tab ?? 'personal'),
        super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();

  static int indexFrom(String tab) {
    switch (tab) {
      case 'personal':
        return 0;
      case 'payment':
        return 1;
      case 'settings':
      default:
        return 2;
    }
  }
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.index,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ProfilePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.index = widget.index;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Профиль'),
          leading: GestureDetector(
              onTap: () {
                context.goNamed('edit');
              },
              child: Icon(
                Icons.edit_note_rounded,
              )),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
            )
          ],
          bottom: TabBar(
            controller: _controller,
            tabs: [
              Tab(text: 'Аккаунт'),
              Tab(text: 'Оплата'),
              Tab(text: 'Настройки'),
            ],
            //onTap: (index) => _tap(context, index),
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            PersonalPage(),
            PaymentPage(),
            SettingPage(),
          ],
        ),
      );
}
