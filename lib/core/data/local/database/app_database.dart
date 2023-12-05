import 'dart:async';
import 'package:floor/floor.dart';
import 'package:fms/core/data/local/database/dao/anime_dao.dart';
import 'package:fms/core/data/local/database/entities/anime_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(
    version: 1,
    entities: [AnimeEntity]
)
abstract class AppDatabase extends FloorDatabase {
  AnimeDao get animeDao;
}