import 'package:fms/core/data/local/database/dao/anime_dao.dart';
import 'package:fms/core/data/local/database/entities/anime_entity.dart';
import 'package:fms/core/utils/typedef_util.dart';
import '../../../../core/utils/future_util.dart';
import 'animelist_repository.dart';

class AnimelistRepositoryImpl extends AnimelistRepository {
  final AnimeDao _dao;

  AnimelistRepositoryImpl(this._dao);

  @override
  FutureOrError<List<AnimeEntity>> getCompletedAnime() {
    return callOrError(() => _dao.getCompletedAnime());
  }

  @override
  FutureOrError<List<AnimeEntity>> getUncompletedAnime() {
    return callOrError(() => _dao.getUncompletedAnime());
  }

  @override
  FutureOrError<void> insertAnime({
    required AnimeEntity animeEntity
  }) {
    return callOrError(() => _dao.insertAnime(animeEntity));
  }

  @override
  FutureOrError<void> addAnimeEpisode({
    required int id,
  }) {
    return callOrError(() => _dao.addAnimeEpisode(id));
  }

  @override
  FutureOrError<void> reduceAnimeEpisode({
    required int id,
  }) {
    return callOrError(() => _dao.reduceAnimeEpisode(id));
  }

  @override
  FutureOrError<void> updateAnime({
    required AnimeEntity animeEntity
  }) {
    return callOrError(() => _dao.updateAnime(animeEntity));
  }

  @override
  FutureOrError<void> deleteAnime({
    required AnimeEntity animeEntity
  }) {
    return callOrError(() => _dao.deleteAnime(animeEntity));
  }

}