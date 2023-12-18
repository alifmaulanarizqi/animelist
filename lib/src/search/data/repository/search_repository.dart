import 'package:fms/core/data/remote/responses/base_response.dart';
import 'package:fms/src/search/data/remote/response/search_response.dart';

import '../../../../core/data/local/database/entities/anime_entity.dart';
import '../../../../core/utils/typedef_util.dart';

abstract class SearchRepository {
  FutureOrError<BaseResponse<List<SearchResponse>>>
  searchAnime({
    int? page,
    int? limit,
    String? q,
  });

  FutureOrError<AnimeEntity?> getAnimeByMalIdLocal({
    required int malId
  });
}