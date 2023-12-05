import 'package:flutter/material.dart';
import 'package:fms/common_ui/utils/colors/common_colors.dart';
import 'package:fms/common_ui/widgets/appbar/common_appbar.dart';
import 'package:fms/src/animelist/presentation/list_anime/list_anime_page.dart';
import 'package:fms/src/search/presentation/search_page.dart';
import 'package:fms/src/season/presentation/season_page.dart';

import '../../../core/utils/value_extension.dart';
import 'args/main_dashboard_arg.dart';

class MainPage extends StatefulWidget {
  static const route = '/home';

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _selectedIndex;
  static const List<Widget> _widgetOptions = <Widget>[
    SearchPage(),
    SeasonPage(),
    ListAnimePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var args = cast<MainDashboardArg>(
      ModalRoute.of(context)?.settings.arguments,
    );
    int indexPage = args?.indexPage ?? 0;
    _selectedIndex = indexPage;
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