import 'package:fms/core/data/remote/responses/base_response.dart';
import 'package:fms/src/detail/data/remote/response/detail_response.dart';

import '../../../../core/utils/typedef_util.dart';

abstract class DetailRepository {
  FutureOrError<BaseResponse<DetailResponse>> getAnimeDetail({
    int? id,
  });
}