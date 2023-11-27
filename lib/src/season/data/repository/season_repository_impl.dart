import 'package:fms/core/data/remote/responses/base_response.dart';
import 'package:fms/core/utils/typedef_util.dart';
import 'package:fms/src/search/data/remote/response/search_response.dart';
import 'package:fms/src/season/data/repository/season_repository.dart';

import '../../../../core/utils/future_util.dart';
import '../remote/service/season_service.dart';

class SeasonRepositoryImpl extends SeasonRepository {
  final SeasonService _seasonService;

  SeasonRepositoryImpl(this._seasonService);

  @override
  FutureOrError<BaseResponse<List<SearchResponse>>> getSeasonNow({
    int? page,
    int? limit,
  }) {
    return callOrError(() => _seasonService.getSeasonNow(
      page: page,
      limit: limit,
    ));
  }

}