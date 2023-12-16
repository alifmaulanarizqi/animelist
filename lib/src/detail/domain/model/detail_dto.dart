class DetailDto {
  final int id;
  final int malId;
  final String title;
  final String type;
  final int episode;
  final String season;
  final int year;
  final int members;
  final double score;
  final String rating;
  final String image;
  final List<String> genres;
  final int popularity;
  final int favorites;
  final bool isAiring;
  final String duration;
  final String synopsis;
  final String youtubeId;
  final String source;
  final List<String> studios;
  final String airedFrom;
  final String airedTo;
  final List<String> licensors;
  final List<Map<String, dynamic>> relations;
  final List<String> openings;
  final List<String> endings;
  final int rank;

  const DetailDto({
    this.id = 0,
    this.malId = 0,
    this.title = '',
    this.type = '',
    this.episode = 0,
    this.season = '',
    this.year = 0,
    this.members = 0,
    this.score = 0,
    this.rating = '',
    this.image = '',
    this.genres = const [],
    this.popularity = 0,
    this.favorites = 0,
    this.isAiring = false,
    this.duration = '',
    this.synopsis = '',
    this.youtubeId = '',
    this.source = '',
    this.studios = const [],
    this.airedFrom = '',
    this.airedTo = '',
    this.licensors = const [],
    this.relations = const [],
    this.openings = const [],
    this.endings = const [],
    this.rank = 0,
  });

  @override
  String toString() {
    return 'DetailDto{title: $title, score: $score, episode: $episode}';
  }
}