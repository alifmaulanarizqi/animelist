import 'package:fms/core/data/remote/responses/base_response.dart';
import 'package:fms/src/search/data/remote/response/search_response.dart';

import '../../../../core/utils/typedef_util.dart';

abstract class SeasonRepository {
  FutureOrError<BaseResponse<List<SearchResponse>>>
  getSeasonNow({
    int? page,
    int? limit,
  });
}