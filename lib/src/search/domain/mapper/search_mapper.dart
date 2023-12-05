import 'package:fms/src/search/data/remote/response/search_response.dart';
import 'package:fms/src/search/domain/model/search_dto.dart';

extension JobItemExt on SearchResponse? {
  SearchDto toDto() {
    return SearchDto(
      title: this?.title ?? '',
      type: this?.type ?? '',
      episode: this?.episodes ?? 0,
      season: this?.season ?? '',
      year: this?.aired?.prop?.from?.year ?? 0,
      members: this?.members ?? 0,
      score: this?.score ?? 0,
      image: this?.images?.jpg?.imageUrl ?? '',
      malId: this?.malId ?? 0,
    );
  }
}