import 'package:fms/core/data/remote/responses/base_response.dart';
import 'package:fms/core/utils/typedef_util.dart';
import 'package:fms/src/search/data/remote/response/search_response.dart';
import 'package:fms/src/search/data/repository/search_repository.dart';

import '../../../../core/data/local/database/dao/anime_dao.dart';
import '../../../../core/data/local/database/entities/anime_entity.dart';
import '../../../../core/utils/future_util.dart';
import '../remote/service/search_service.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchService _searchService;
  final AnimeDao _dao;

  SearchRepositoryImpl(this._searchService, this._dao);

  @override
  FutureOrError<BaseResponse<List<SearchResponse>>> searchAnime({
    int? page,
    int? limit,
    String? q
  }) {
    return callOrError(() => _searchService.searchAnime(
      page: page,
      limit: limit,
      q: q,
    ));
  }

  @override
  FutureOrError<AnimeEntity?> getAnimeByMalIdLocal({
    required int malId
  }) {
    return callOrError(() => _dao.getAnimeByMalId(malId));
  }

}