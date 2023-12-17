import 'package:fms/core/data/remote/responses/base_response.dart';
import 'package:fms/src/detail/data/remote/response/detail_response.dart';

import '../../../../core/data/local/database/dao/anime_dao.dart';
import '../../../../core/data/local/database/entities/anime_entity.dart';
import '../../../../core/utils/future_util.dart';
import '../../../../core/utils/typedef_util.dart';
import '../remote/service/detail_service.dart';
import 'detail_repository.dart';

class DetailRepositoryImpl extends DetailRepository {
  final DetailService _detailService;
  final AnimeDao _dao;

  DetailRepositoryImpl(this._detailService, this._dao);

  @override
  FutureOrError<BaseResponse<DetailResponse>> getAnimeDetail({
    int? malId,
  }) {
    return callOrError(() => _detailService.getAnimeDetail(
      malId: malId,
    ));
  }

  @override
  FutureOrError<AnimeEntity?> getAnimeByMalIdLocal({
    required int malId
  }) {
    return callOrError(() => _dao.getAnimeByMalId(malId));
  }

}