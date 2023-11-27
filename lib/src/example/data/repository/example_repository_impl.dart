import 'package:fms/core/data/remote/responses/base_response.dart';
import 'package:fms/src/example/data/remote/responses/example_response.dart';
import 'package:fms/src/example/data/remote/services/example_service.dart';
import 'package:fms/src/example/data/repository/example_repository.dart';
import 'package:fms/core/utils/future_util.dart';
import 'package:fms/core/utils/typedef_util.dart';

class ExampleRepositoryImpl extends ExampleRepository {
  final ExampleService exampleService;

  ExampleRepositoryImpl(this.exampleService);

  @override
  FutureOrError<BaseResponse<List<ExampleResponse>>> getRecipes({
    String? apiKey
  }) {
    return callOrError(() => exampleService.getRecipes(apiKey: apiKey));
  }
}
