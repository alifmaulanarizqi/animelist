import 'package:either_dart/either.dart';
import 'package:fms/core/data/local/database/entities/anime_entity.dart';
import 'package:fms/src/animelist/data/repository/animelist_repository.dart';

import '../../../../core/data/remote/responses/base_response.dart';
import '../../../../core/utils/typedef_util.dart';

class ListAnimeUseCase {
  final AnimelistRepository _repository;

  ListAnimeUseCase(this._repository);

  FutureOrError<BaseResponse<List<AnimeEntity>>> getAnimeList({
    int? tab,
  }) async {
    if(tab == 0) {
      return _repository
          .getUncompletedAnime()
          .mapRight((response) {
        return BaseResponse(
          data: response,
          pagination: PaginationBaseResponse(
            lastVisiblePage: 1,
            hasNextPage: false,
            currentPage: 1,
            items: ItemPaginationBaseResponse(
              count: response.length,
              total: response.length,
              perPage: response.length,
            ),
          ),
        );
      });
    } else {
      return _repository
          .getCompletedAnime()
          .mapRight((response) {
        return BaseResponse(
          data: response,
          pagination: PaginationBaseResponse(
            lastVisiblePage: 1,
            hasNextPage: false,
            currentPage: 1,
            items: ItemPaginationBaseResponse(
              count: response.length,
              total: response.length,
              perPage: response.length,
            ),
          ),
        );
      });
    }
  }

  FutureOrError<void> addAnimeEpisode({
    required int id,
  }) async {
    return _repository.addAnimeEpisode(
      id: id,
    );
  }

  FutureOrError<void> reduceAnimeEpisode({
    required int id,
  }) async {
    return _repository.reduceAnimeEpisode(
      id: id,
    );
  }

  FutureOrError<void> updateIsCompletedColumn({
    required int id,
  }) async {
    return _repository.updateIsCompletedColumn(
      id: id,
    );
  }
}