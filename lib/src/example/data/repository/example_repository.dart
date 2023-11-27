import 'package:fms/core/data/remote/responses/base_response.dart';
import 'package:fms/core/utils/typedef_util.dart';
import 'package:fms/src/example/data/remote/responses/example_response.dart';

abstract class ExampleRepository {
  FutureOrError<BaseResponse<List<ExampleResponse>>> getRecipes({
    String? apiKey
  });
}
