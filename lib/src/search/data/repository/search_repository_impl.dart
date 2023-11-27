import 'package:fms/core/data/remote/responses/base_response.dart';
import 'package:fms/core/utils/typedef_util.dart';
import 'package:fms/src/search/data/remote/response/search_response.dart';
import 'package:fms/src/search/data/repository/search_repository.dart';

import '../../../../core/utils/future_util.dart';
import '../remote/service/search_service.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchService _searchService;

  SearchRepositoryImpl(this._searchService);

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

}