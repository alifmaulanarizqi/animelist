import 'package:fms/common_ui/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:fms/src/animelist/presentation/add_anime/add_anime_page.dart';
import 'package:fms/src/animelist/presentation/list_anime/list_anime_page.dart';
import 'package:fms/src/detail/presentation/detail_page.dart';
import 'package:fms/src/main/main_dashboard/main_dashboard.dart';
import 'package:fms/src/search/presentation/search_page.dart';
import 'package:fms/src/season/presentation/season_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.Up
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animelist',
      theme: ThemeData(
        colorScheme: lightColorScheme,
        navigationBarTheme: const NavigationBarThemeData(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: MainPage.route,
      routes: {
        MainPage.route: (ctx) => const MainPage(),
        SearchPage.route: (ctx) => const SearchPage(),
        SeasonPage.route: (ctx) => const SeasonPage(),
        DetailPage.route: (ctx) => const DetailPage(),
        AddAnimePage.route: (ctx) => const AddAnimePage(),
        ListAnimePage.route: (ctx) => const ListAnimePage(),
      },
    );
  }
}
