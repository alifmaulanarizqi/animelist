import 'package:json_annotation/json_annotation.dart';

import '../../../../search/data/remote/response/search_response.dart';

part 'detail_response.g.dart';

@JsonSerializable()
class DetailResponse {
  @JsonKey(name: 'mal_id')
  int? malId;
  @JsonKey(name: 'url')
  String? url;
  @JsonKey(name: 'images')
  ImagesSearch? images;
  @JsonKey(name: 'trailer')
  AnimeTrailer? trailer;
  @JsonKey(name: 'approved')
  bool? approved;
  @JsonKey(name: 'titles')
  List<AnimeTitle>? titles;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'title_english')
  String? titleEnglish;
  @JsonKey(name: 'title_japanese')
  String? titleJapanese;
  @JsonKey(name: 'title_synonyms')
  List<String>? titleSynonyms;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'source')
  String? source;
  @JsonKey(name: 'episodes')
  int? episodes;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'airing')
  bool? airing;
  @JsonKey(name: 'aired')
  AiredAnime? aired;
  @JsonKey(name: 'duration')
  String? duration;
  @JsonKey(name: 'rating')
  String? rating;
  @JsonKey(name: 'score')
  double? score;
  @JsonKey(name: 'score_by')
  int? scoreBy;
  @JsonKey(name: 'rank')
  int? rank;
  @JsonKey(name: 'popularity')
  int? popularity;
  @JsonKey(name: 'members')
  int? members;
  @JsonKey(name: 'favorites')
  int? favorites;
  @JsonKey(name: 'synopsis')
  String? synopsis;
  @JsonKey(name: 'background')
  String? background;
  @JsonKey(name: 'season')
  String? season;
  @JsonKey(name: 'year')
  int? year;
  @JsonKey(name: 'broadcast')
  BroadcastAnime? broadcast;
  @JsonKey(name: 'producers')
  List<ProducerAnime>? producers;
  @JsonKey(name: 'licensors')
  List<ProducerAnime>? licensors;
  @JsonKey(name: 'studios')
  List<ProducerAnime>? studios;
  @JsonKey(name: 'genres')
  List<ProducerAnime>? genres;
  @JsonKey(name: 'explicit_genres')
  List<ProducerAnime>? explicitGenres;
  @JsonKey(name: 'themes')
  List<ProducerAnime>? themes;
  @JsonKey(name: 'demographics')
  List<ProducerAnime>? demographics;
  @JsonKey(name: 'relations')
  List<RelationAnime>? relations;
  @JsonKey(name: 'theme')
  ThemeAnime? theme;
  @JsonKey(name: 'external')
  List<ProducerAnime>? external;
  @JsonKey(name: 'streaming')
  List<ProducerAnime>? streaming;

  DetailResponse(
      {this.malId,
        this.url,
        this.images,
        this.trailer,
        this.approved,
        this.titles,
        this.title,
        this.titleEnglish,
        this.titleJapanese,
        this.titleSynonyms,
        this.type,
        this.source,
        this.episodes,
        this.status,
        this.airing,
        this.aired,
        this.duration,
        this.rating,
        this.score,
        this.scoreBy,
        this.rank,
        this.popularity,
        this.members,
        this.favorites,
        this.synopsis,
        this.background,
        this.season,
        this.year,
        this.broadcast,
        this.producers,
        this.licensors,
        this.studios,
        this.genres,
        this.explicitGenres,
        this.themes,
        this.demographics,
        this.relations,
        this.theme,
        this.external,
        this.streaming,
      });

  factory DetailResponse.fromJson(Map<String, dynamic> json) => _$DetailResponseFromJson(json);
}

@JsonSerializable()
class RelationAnime {
  @JsonKey(name: 'relation')
  String? relation;
  @JsonKey(name: 'entry')
  List<ProducerAnime>? entry;

  RelationAnime({
    this.relation,
    this.entry,
  });

  factory RelationAnime.fromJson(Map<String, dynamic> json) => _$RelationAnimeFromJson(json);
}

@JsonSerializable()
class ThemeAnime {
  @JsonKey(name: 'openings')
  List<String>? opening;
  @JsonKey(name: 'endings')
  List<String>? ending;

  ThemeAnime({this.opening, this.ending,});

  factory ThemeAnime.fromJson(Map<String, dynamic> json) => _$ThemeAnimeFromJson(json);
}