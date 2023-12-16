import 'package:fms/core/data/local/database/entities/anime_entity.dart';

import '../../../../core/utils/typedef_util.dart';

abstract class AnimelistRepository {
  FutureOrError<List<AnimeEntity>> getUncompletedAnime();

  FutureOrError<List<AnimeEntity>> getCompletedAnime();

  FutureOrError<void> insertAnime({
    required AnimeEntity animeEntity
  });

  FutureOrError<void> addAnimeEpisode({
    required int id
  });

  FutureOrError<void> reduceAnimeEpisode({
    required int id
  });

  FutureOrError<void> updateAnime({
    required AnimeEntity animeEntity
  });

  FutureOrError<void> deleteAnime({
    required AnimeEntity animeEntity
  });

  FutureOrError<void> updateIsCompletedColumn({
    required int id
  });
}
