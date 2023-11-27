import 'package:fms/core/data/remote/responses/base_response.dart';
import 'package:fms/src/example/data/remote/responses/example_response.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'example_service.g.dart';

@RestApi()
abstract class ExampleService {
  factory ExampleService(Dio dio) => _ExampleService(dio);

  @GET('/recipes/complexSearch')
  Future<BaseResponse<List<ExampleResponse>>> getRecipes({
    @Query('apiKey') String? apiKey,
  });
}
