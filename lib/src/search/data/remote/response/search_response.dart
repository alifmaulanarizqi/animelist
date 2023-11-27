import 'package:json_annotation/json_annotation.dart';

part 'search_response.g.dart';

@JsonSerializable()
class SearchResponse {
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
  @JsonKey(name: 'pupularity')
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

  SearchResponse(
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
      });

  factory SearchResponse.fromJson(Map<String, dynamic> json) => _$SearchResponseFromJson(json);
}

@JsonSerializable()
class ImagesSearch {
  @JsonKey(name: 'jpg')
  ImagesUrl? jpg;
  @JsonKey(name: 'webp')
  ImagesUrl? webp;

  ImagesSearch({this.jpg, this.webp,});

  factory ImagesSearch.fromJson(Map<String, dynamic> json) => _$ImagesSearchFromJson(json);
}

@JsonSerializable()
class ImagesUrl {
  @JsonKey(name: 'image_url')
  String? imageUrl;
  @JsonKey(name: 'small_image_url')
  String? smallImageUrl;
  @JsonKey(name: 'medium_image_url')
  String? mediumImageUrl;
  @JsonKey(name: 'large_image_url')
  String? largeImageUrl;
  @JsonKey(name: 'maximum_image_url')
  String? maximumImageUrl;

  ImagesUrl({
    this.imageUrl,
    this.smallImageUrl,
    this.mediumImageUrl,
    this.largeImageUrl,
    this.maximumImageUrl,
  });

  factory ImagesUrl.fromJson(Map<String, dynamic> json) => _$ImagesUrlFromJson(json);
}

@JsonSerializable()
class AnimeTrailer {
  @JsonKey(name: 'youtube_id')
  String? youtubeId;
  @JsonKey(name: 'url')
  String? url;
  @JsonKey(name: 'embed_url')
  String? embedUrl;
  @JsonKey(name: 'images')
  ImagesUrl? images;

  AnimeTrailer({
    this.youtubeId,
    this.url,
    this.embedUrl,
    this.images,
  });

  factory AnimeTrailer.fromJson(Map<String, dynamic> json) => _$AnimeTrailerFromJson(json);
}

@JsonSerializable()
class AnimeTitle {
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'title')
  String? title;

  AnimeTitle({this.type, this.title,});

  factory AnimeTitle.fromJson(Map<String, dynamic> json) => _$AnimeTitleFromJson(json);
}

@JsonSerializable()
class AiredAnime {
  @JsonKey(name: 'from')
  String? from;
  @JsonKey(name: 'to')
  String? to;
  @JsonKey(name: 'prop')
  PropAiredAnime? prop;
  @JsonKey(name: 'string')
  String? string;

  AiredAnime({
    this.from,
    this.to,
    this.prop,
    this.string,
  });

  factory AiredAnime.fromJson(Map<String, dynamic> json) => _$AiredAnimeFromJson(json);
}

@JsonSerializable()
class PropAiredAnime {
  @JsonKey(name: 'from')
  PropAiredAnimeItem? from;
  @JsonKey(name: 'to')
  PropAiredAnimeItem? to;

  PropAiredAnime({this.from, this.to,});

  factory PropAiredAnime.fromJson(Map<String, dynamic> json) => _$PropAiredAnimeFromJson(json);
}

@JsonSerializable()
class PropAiredAnimeItem {
  @JsonKey(name: 'day')
  int? day;
  @JsonKey(name: 'month')
  int? month;
  @JsonKey(name: 'year')
  int? year;

  PropAiredAnimeItem({
    this.day,
    this.month,
    this.year,
  });

  factory PropAiredAnimeItem.fromJson(Map<String, dynamic> json) => _$PropAiredAnimeItemFromJson(json);
}

@JsonSerializable()
class BroadcastAnime {
  @JsonKey(name: 'day')
  String? day;
  @JsonKey(name: 'time')
  String? time;
  @JsonKey(name: 'timezone')
  String? timezone;
  @JsonKey(name: 'string')
  String? string;

  BroadcastAnime({
    this.day,
    this.time,
    this.timezone,
    this.string,
  });

  factory BroadcastAnime.fromJson(Map<String, dynamic> json) => _$BroadcastAnimeFromJson(json);
}

@JsonSerializable()
class ProducerAnime {
  @JsonKey(name: 'mal_id')
  int? malId;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'url')
  String? url;

  ProducerAnime({
    this.malId,
    this.type,
    this.name,
    this.url,
  });

  factory ProducerAnime.fromJson(Map<String, dynamic> json) => _$ProducerAnimeFromJson(json);
}



