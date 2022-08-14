import 'package:feedback24_app/personal_editing/view/edit_payment_page.dart';
import 'package:feedback24_app/personal_editing/view/personal_editing_page.dart';
import 'package:flutter/material.dart';

class EditTabBarPage extends StatefulWidget {
  const EditTabBarPage({Key? key}) : super(key: key);
  @override
  _EditTabBarPageState createState() => _EditTabBarPageState();
}

class _EditTabBarPageState extends State<EditTabBarPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              title: const Text('Изменение данных'),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                )
              ],
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: "Данные",
                  ),
                  Tab(
                    text: "Реквизиты",
                  ),
                ],
              )),
          body: TabBarView(
            children: [
              PersonalEditPage(),
              EditPaymentPage(),
            ],
          ),
        ));
  }
}
