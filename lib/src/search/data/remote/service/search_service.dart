import 'package:dio/dio.dart';
import 'package:fms/src/search/data/remote/response/search_response.dart';
import 'package:retrofit/http.dart';

import '../../../../../core/data/remote/responses/base_response.dart';

part 'search_service.g.dart';

@RestApi()
abstract class SearchService {
  factory SearchService(Dio dio) => _SearchService(dio);

  @GET('/anime')
  Future<BaseResponse<List<SearchResponse>>> searchAnime({
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('q') String? q,
  });
}