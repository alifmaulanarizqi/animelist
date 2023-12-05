import 'package:fms/core/data/local/database/entities/anime_entity.dart';

import '../../../../core/utils/typedef_util.dart';

abstract class AnimelistRepository {
  FutureOrError<List<AnimeEntity>> getUncompletedAnime();

  FutureOrError<List<AnimeEntity>> getCompletedAnime();

  FutureOrError<void> insertAnime({
    required AnimeEntity animeEntity
  });
}
