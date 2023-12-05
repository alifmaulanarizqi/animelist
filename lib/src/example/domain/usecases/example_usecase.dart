import 'package:either_dart/either.dart';
import 'package:fms/core/domain/models/base_pagination_dto.dart';
import 'package:fms/src/example/data/remote/responses/example_response.dart';
import 'package:fms/src/example/data/repository/example_repository.dart';
import 'package:fms/src/example/domain/mapper/example_mapper.dart';
import 'package:fms/src/example/domain/models/example_dto.dart';

import '../../../../core/utils/typedef_util.dart';

class ExampleUseCase {
  final ExampleRepository _repository;
  ExampleUseCase(this._repository);

  FutureOrError<BaseResponseDto<ExampleDto>> execute({
    String? apiKey,
  }) {
    return _repository.getRecipes(
      apiKey: apiKey ?? '').mapRight((response) {
        var results = response.results?.map(_mapCourse).toList();
        return BaseResponseDto(
          results: results ?? [],
          offset: response.offset ?? 0,
          number: response.number ?? 0,
          totalResults: response.totalResults ?? 0
        );
    });
  }

  ExampleDto _mapCourse(ExampleResponse response) {
    return response.toDto();
  }
}
