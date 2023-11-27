import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../../../core/data/remote/responses/base_response.dart';
import '../../../../search/data/remote/response/search_response.dart';

part 'season_service.g.dart';

@RestApi()
abstract class SeasonService {
  factory SeasonService(Dio dio) => _SeasonService(dio);

  @GET('/seasons/now')
  Future<BaseResponse<List<SearchResponse>>> getSeasonNow({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });
}