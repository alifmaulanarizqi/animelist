import 'package:floor/floor.dart';

@Entity(tableName: 'Anime')
class AnimeEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;
  @ColumnInfo(name: 'mal_id')
  final int? malId;
  @ColumnInfo(name: 'title')
  final String? title;
  @ColumnInfo(name: 'image_url')
  final String? imageUrl;
  @ColumnInfo(name: 'type')
  final String? type;
  @ColumnInfo(name: 'season')
  final String? season;
  @ColumnInfo(name: 'year')
  final int? year;
  @ColumnInfo(name: 'score')
  int? score;
  @ColumnInfo(name: 'total_episode')
  final int? totalEpisode;
  @ColumnInfo(name: 'progress_episode')
  int progressEpisode;
  @ColumnInfo(name: 'is_completed')
  final int isCompleted;

  AnimeEntity({
    this.id,
    this.malId,
    this.title,
    this.imageUrl,
    this.type,
    this.season,
    this.year,
    this.score,
    this.totalEpisode,
    this.progressEpisode = 1,
    this.isCompleted = 0,
  });

  AnimeEntity copyWith({
    int? id,
    int? malId,
    String? title,
    String? imageUrl,
    String? type,
    String? season,
    int? year,
    int? score,
    int? totalEpisode,
    int? progressEpisode,
    int? isCompleted,
  }) {
    return AnimeEntity(
      id: id ?? this.id,
      malId: malId ?? this.malId,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      type: type ?? this.type,
      season: season ?? this.season,
      year: year ?? this.year,
      score: score ?? this.score,
      totalEpisode: totalEpisode ?? this.totalEpisode,
      progressEpisode: progressEpisode ?? this.progressEpisode,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}