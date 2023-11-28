import 'package:intl/intl.dart';

import 'package:fms/src/detail/data/remote/response/detail_response.dart';
import 'package:fms/src/detail/domain/model/detail_dto.dart';

extension JobItemExt on DetailResponse? {
  DetailDto toDto() {
    List<String> studios = [];
    this?.studios?.forEach((element) {
      studios.add(element.name ?? '');
    });

    String airedFrom = '?';
    String airedTo = '?';
    if(this?.aired?.from != null) {
      airedFrom = DateFormat('MMM d, yyyy').format(DateTime.parse(this?.aired?.from ?? ''));
    } else if(this?.aired?.to != null) {
      airedTo = DateFormat('MMM d, yyyy').format(DateTime.parse(this?.aired?.to ?? ''));
    }

    List<String> licensors = [];
    this?.licensors?.forEach((element) {
      licensors.add(element.name ?? '');
    });

    List<String> openings = [];
    this?.theme?.opening?.forEach((element) {
      openings.add(element ?? '');
    });

    List<String> endings = [];
    this?.theme?.ending?.forEach((element) {
      endings.add(element ?? '');
    });

    List<Map<String, dynamic>> relations = [];
    this?.relations?.forEach((outerElement) {
      Map<String, dynamic> relation = {
        'relation': outerElement.relation ?? '',
        'entry': [],
      };

      outerElement.entry?.forEach((innerElement) {
        var malId = innerElement.malId ?? 0;
        var name = innerElement.name ?? '';

        relation['entry']?.add({
          'mal_id': malId.toString(),
          'name': name,
        });
      });

      relations.add(relation);
    });

    var indexMinString = this?.duration?.indexOf("min") ?? 0;
    var duration = this?.duration?.substring(0, indexMinString + 3);

    List<String> genres = [];
    this?.genres?.forEach((element) {
      genres.add(element.name ?? '');
    });

    return DetailDto(
      title: this?.title ?? '',
      type: this?.type ?? '',
      episode: this?.episodes ?? 0,
      season: this?.season ?? '',
      year: this?.aired?.prop?.from?.year ?? 0,
      members: this?.members ?? 0,
      score: this?.score ?? 0,
      image: this?.images?.jpg?.imageUrl ?? '',
      rating: this?.rating ?? '',
      popularity: this?.popularity ?? 0,
      favorites: this?.favorites ?? 0,
      isAiring: this?.airing ?? false,
      duration: duration ?? '',
      synopsis: this?.synopsis ?? '',
      youtubeId: this?.trailer?.youtubeId ?? '',
      source: this?.source ?? '',
      studios: studios,
      airedFrom: airedFrom ?? '',
      airedTo: airedTo ?? '',
      licensors: licensors,
      relations: relations,
      openings: openings,
      endings: endings,
      rank: this?.rank ?? 0,
      genres: genres,
    );
  }
}