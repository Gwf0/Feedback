import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:feedback24_app/profile/profile.dart' show ProfilePage;
import 'package:feedback24_app/audits/audits.dart' show AuditsPage;
import 'package:feedback24_app/map/map.dart' show MapPage;

class HomePage extends StatefulWidget {
  final int index;

  HomePage({required String tab, Key? key})
      : index = indexFrom(tab),
        super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

  static int indexFrom(String tab) {
    switch (tab) {
      case 'audit':
        return 1;
      case 'profile':
        return 2;
      case 'map':
      default:
        return 0;
    }
  }
}

class _HomePageState extends State<HomePage> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Проверки'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(
            () {
              _selectedIndex = index;
              switch (index) {
                case 0:
                  context.go('/map');
                  break;
                case 1:
                  context.go('/audit');
                  break;
                case 2:
                  context.go('/profile');
                  break;
              }
            },
          );
        },
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [MapPage(), AuditsPage(), ProfilePage()],
      ),
    );
  }
}
