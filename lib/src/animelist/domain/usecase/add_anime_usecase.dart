import 'package:fms/core/data/local/database/entities/anime_entity.dart';

import '../../../../core/utils/typedef_util.dart';
import '../../data/repository/animelist_repository.dart';

class AddAnimeUseCase {
  final AnimelistRepository _repository;

  AddAnimeUseCase(this._repository);

  FutureOrError<void> insert({
    required AnimeEntity animeEntity,
  }) async {
    return _repository.insertAnime(
      animeEntity: animeEntity,
    );
  }

  FutureOrError<void> update({
    required AnimeEntity animeEntity,
  }) async {
    return _repository.updateAnime(
      animeEntity: animeEntity,
    );
  }

  FutureOrError<void> delete({
    required AnimeEntity animeEntity,
  }) async {
    return _repository.deleteAnime(
      animeEntity: animeEntity,
    );
  }
}