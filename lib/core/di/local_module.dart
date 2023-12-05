import 'package:fms/core/data/local/app_preferences.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/local/database/app_database.dart';
import '../data/local/database/dao/anime_dao.dart';

@module
abstract class LocalModule {
  @singleton
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @singleton
  AppPreferences appPreferences(SharedPreferences prefs) =>
      AppPreferences(prefs);

  @singleton
  @preResolve
  Future<AppDatabase> appDatabase() async =>
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  @singleton
   AnimeDao animeDao(AppDatabase appDatabase) =>
      appDatabase.animeDao;
}
