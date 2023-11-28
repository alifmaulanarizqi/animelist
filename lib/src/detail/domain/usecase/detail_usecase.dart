import 'package:either_dart/either.dart';
import 'package:fms/core/data/remote/responses/base_response.dart';
import 'package:fms/src/detail/domain/mapper/detail_mapper.dart';

import '../../../../core/utils/typedef_util.dart';
import '../../data/repository/detail_repository.dart';
import '../model/detail_dto.dart';

class DetailUseCase {
  final DetailRepository _repository;

  DetailUseCase(this._repository);

  FutureOrError<BaseResponse<DetailDto>> execute({
    required int id,
  }) async {
    return _repository.getAnimeDetail(
      id: id,
    ).mapRight((response) {
      return BaseResponse(
        data: response.data.toDto()
      );
    });
  }
}