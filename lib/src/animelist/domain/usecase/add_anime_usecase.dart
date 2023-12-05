import 'package:fms/core/data/local/database/entities/anime_entity.dart';

import '../../../../core/utils/typedef_util.dart';
import '../../data/repository/animelist_repository.dart';

class AddAnimeUseCase {
  final AnimelistRepository _repository;

  AddAnimeUseCase(this._repository);

  FutureOrError<void> execute({
    required AnimeEntity animeEntity,
  }) async {
    return _repository.insertAnime(
      animeEntity: animeEntity,
    );
  }
}