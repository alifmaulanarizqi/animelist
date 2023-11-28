import 'package:fms/core/data/remote/responses/base_response.dart';
import 'package:fms/src/detail/data/remote/response/detail_response.dart';

import '../../../../core/utils/future_util.dart';
import '../../../../core/utils/typedef_util.dart';
import '../remote/service/detail_service.dart';
import 'detail_repository.dart';

class DetailRepositoryImpl extends DetailRepository {
  final DetailService _detailService;

  DetailRepositoryImpl(this._detailService);

  @override
  FutureOrError<BaseResponse<DetailResponse>> getAnimeDetail({
    int? id,
  }) {
    return callOrError(() => _detailService.getAnimeDetail(
      id: id,
    ));
  }

}