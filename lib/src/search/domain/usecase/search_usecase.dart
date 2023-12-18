import 'package:either_dart/either.dart';
import 'package:fms/core/data/remote/responses/base_response.dart';
import 'package:fms/src/search/data/remote/response/search_response.dart';
import 'package:fms/src/search/data/repository/search_repository.dart';
import 'package:fms/src/search/domain/mapper/search_mapper.dart';

import '../../../../core/data/local/database/entities/anime_entity.dart';
import '../../../../core/utils/typedef_util.dart';
import '../model/search_dto.dart';

class SearchUseCase {
  final SearchRepository _repository;

  SearchUseCase(this._repository);

  FutureOrError<BaseResponse<List<SearchDto>>> execute({
    int? page,
    int? limit,
    String? q,
  }) async {
    return _repository.searchAnime(
      page: page,
      limit: limit,
      q: q,
    ).mapRight((response) {
      var data = response.data?.map(_mapSearch).toList() ?? [];

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

  SearchDto _mapSearch(SearchResponse searchResponse) {
    return searchResponse.toDto();
  }
}