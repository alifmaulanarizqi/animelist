import 'package:flutter/material.dart';

class ListAnimePage extends StatefulWidget {
  static const route = '/animelist';

  const ListAnimePage({Key? key}) : super(key: key);

  @override
  State<ListAnimePage> createState() => _ListAnimePageState();
}

class _ListAnimePageState extends State<ListAnimePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Animelist page'),
    );
  }

}