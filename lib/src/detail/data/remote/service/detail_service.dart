import 'package:dio/dio.dart';
import 'package:fms/core/data/remote/responses/base_response.dart';
import 'package:fms/src/detail/data/remote/response/detail_response.dart';
import 'package:retrofit/http.dart';

part 'detail_service.g.dart';

@RestApi()
abstract class DetailService {
  factory DetailService(Dio dio) => _DetailService(dio);

  @GET('/anime/{id}/full')
  Future<BaseResponse<DetailResponse>> getAnimeDetail({
    @Path('id') int? id,
  });
}