import 'package:floor/floor.dart';
import 'package:fms/core/data/local/database/entities/anime_entity.dart';

@dao
abstract class AnimeDao {
  @Query('SELECT * FROM Anime WHERE is_completed = 0')
  Future<List<AnimeEntity>> getUncompletedAnime();

  @Query('SELECT * FROM Anime WHERE is_completed = 1')
  Future<List<AnimeEntity>> getCompletedAnime();

  @insert
  Future<void> insertAnime(AnimeEntity animeEntity);

  @Query("UPDATE Anime SET progress_episode = progress_episode + 1 WHERE id = :id")
  Future<void> addAnimeEpisode(int id);

  @Query("UPDATE Anime SET progress_episode = progress_episode - 1 WHERE id = :id")
  Future<void> reduceAnimeEpisode(int id);

  //
  // @Query('SELECT name FROM Person')
  // Stream<List<String>> findAllPeopleName();
  //
  // @Query('SELECT * FROM Person WHERE id = :id')
  // Stream<Person?> findPersonById(int id);
  //
}