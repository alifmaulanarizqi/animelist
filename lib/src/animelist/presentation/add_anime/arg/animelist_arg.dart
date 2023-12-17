import 'package:fms/src/detail/domain/model/detail_dto.dart';

class AnimelistArg {
  final DetailDto? detailDto;
  final int? progressEpisode;
  final int? score;

  AnimelistArg({
    this.detailDto,
    this.progressEpisode,
    this.score,
  });
}