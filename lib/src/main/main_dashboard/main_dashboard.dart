import 'package:flutter/material.dart';
import 'package:fms/common_ui/utils/colors/common_colors.dart';
import 'package:fms/common_ui/widgets/appbar/common_appbar.dart';
import 'package:fms/src/detail/presentation/detail_page.dart';
import 'package:fms/src/search/presentation/search_page.dart';
import 'package:fms/src/season/presentation/season_page.dart';

class MainPage extends StatelessWidget {
  static const route = '/home';

  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomNavigationBarExample();
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    SearchPage(),
    SeasonPage(),
    Text('Animelist')
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppbar(
        textTitle: "Animelist",
        textColor: Colors.white,
        backgroundColor: CommonColors.blueB5,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sunny_snowing),
            label: 'Season',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Animelist',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: CommonColors.orange00,
        onTap: _onItemTapped,
        backgroundColor: CommonColors.greyF2,
      ),
    );
  }
}