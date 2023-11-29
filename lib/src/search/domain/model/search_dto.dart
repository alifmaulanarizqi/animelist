class SearchDto {
  final String title;
  final String type;
  final int episode;
  final String season;
  final int year;
  final int members;
  final double score;
  final String image;
  final List<String> genres;
  final int malId;

  const SearchDto({
    this.title = '',
    this.type = '',
    this.episode = 0,
    this.season = '',
    this.year = 0,
    this.members = 0,
    this.score = 0,
    this.image = '',
    this.genres = const [],
    this.malId = 0,
  });

  @override
  String toString() {
    return 'SearchDto{title: $title, score: $score, episode: $episode}';
  }
}