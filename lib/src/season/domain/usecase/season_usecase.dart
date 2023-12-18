import 'package:either_dart/either.dart';
import 'package:fms/src/season/domain/mapper/season_mapper.dart';

import '../../../../core/data/local/database/entities/anime_entity.dart';
import '../../../../core/data/remote/responses/base_response.dart';
import '../../../../core/utils/typedef_util.dart';
import '../../../search/data/remote/response/search_response.dart';
import '../../../search/domain/model/search_dto.dart';
import '../../data/repository/season_repository.dart';

class SeasonUseCase {
  final SeasonRepository _repository;

  SeasonUseCase(this._repository);

  FutureOrError<BaseResponse<List<SearchDto>>> getSeasonNow({
    int? page,
    int? limit,
    String? q,
  }) async {
    return _repository.getSeasonNow(
      page: page,
      limit: limit,
    ).mapRight((response) {
      var data = response.data?.map(_mapSeason).toList() ?? [];

      return BaseResponse(
        data: data,
        pagination: response.pagination,
      );
    });
  }

  FutureOrError<BaseResponse<AnimeEntity>> getAnimeByMalIdLocal({
    required int malId,
  }) async {
    return _repository.getAnimeByMalIdLocal(
      malId: malId,
    ).mapRight((response) {
      return BaseResponse(
          data: response
      );
    });
  }

  SearchDto _mapSeason(SearchResponse searchResponse) {
    return searchResponse.toDto();
  }
}