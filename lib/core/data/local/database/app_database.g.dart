// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AnimeDao? _animeDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Anime` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `mal_id` INTEGER, `title` TEXT, `image_url` TEXT, `type` TEXT, `season` TEXT, `year` INTEGER, `score` INTEGER, `total_episode` INTEGER, `progress_episode` INTEGER, `is_completed` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AnimeDao get animeDao {
    return _animeDaoInstance ??= _$AnimeDao(database, changeListener);
  }
}

class _$AnimeDao extends AnimeDao {
  _$AnimeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _animeEntityInsertionAdapter = InsertionAdapter(
            database,
            'Anime',
            (AnimeEntity item) => <String, Object?>{
                  'id': item.id,
                  'mal_id': item.malId,
                  'title': item.title,
                  'image_url': item.imageUrl,
                  'type': item.type,
                  'season': item.season,
                  'year': item.year,
                  'score': item.score,
                  'total_episode': item.totalEpisode,
                  'progress_episode': item.progressEpisode,
                  'is_completed': item.isCompleted
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AnimeEntity> _animeEntityInsertionAdapter;

  @override
  Future<List<AnimeEntity>> getUncompletedAnime() async {
    return _queryAdapter.queryList('SELECT * FROM Anime WHERE is_completed = 0',
        mapper: (Map<String, Object?> row) => AnimeEntity(
            id: row['id'] as int?,
            malId: row['mal_id'] as int?,
            title: row['title'] as String?,
            imageUrl: row['image_url'] as String?,
            type: row['type'] as String?,
            season: row['season'] as String?,
            year: row['year'] as int?,
            score: row['score'] as int?,
            totalEpisode: row['total_episode'] as int?,
            progressEpisode: row['progress_episode'] as int?,
            isCompleted: row['is_completed'] as int?));
  }

  @override
  Future<List<AnimeEntity>> getCompletedAnime() async {
    return _queryAdapter.queryList('SELECT * FROM Anime WHERE is_completed = 1',
        mapper: (Map<String, Object?> row) => AnimeEntity(
            id: row['id'] as int?,
            malId: row['mal_id'] as int?,
            title: row['title'] as String?,
            imageUrl: row['image_url'] as String?,
            type: row['type'] as String?,
            season: row['season'] as String?,
            year: row['year'] as int?,
            score: row['score'] as int?,
            totalEpisode: row['total_episode'] as int?,
            progressEpisode: row['progress_episode'] as int?,
            isCompleted: row['is_completed'] as int?));
  }

  @override
  Future<void> insertAnime(AnimeEntity animeEntity) async {
    await _animeEntityInsertionAdapter.insert(
        animeEntity, OnConflictStrategy.abort);
  }
}
