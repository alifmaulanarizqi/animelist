part of 'list_anime_bloc.dart';

abstract class ListAnimeEvent extends Equatable {
  const ListAnimeEvent();
}

class ListAnimeInitEvent extends ListAnimeEvent {
  final int tab;

  const ListAnimeInitEvent({
    required this.tab,
  });

  @override
  List<Object?> get props => [tab];
}

class AddAnimeEpisodeEvent extends ListAnimeEvent {
  final int id;
  final int progressEpisode;
  final int totalEpisode;

  const AddAnimeEpisodeEvent({
    required this.id,
    required this.progressEpisode,
    required this.totalEpisode,
  });

  @override
  List<Object?> get props => [id, progressEpisode, totalEpisode];
}

class ReduceAnimeEpisodeEvent extends ListAnimeEvent {
  final int id;
  final int progressEpisode;

  const ReduceAnimeEpisodeEvent({
    required this.id,
    required this.progressEpisode,
  });

  @override
  List<Object?> get props => [id, progressEpisode];
}

class UpdateIsCompletedEvent extends ListAnimeEvent {
  final int id;
  final int totalEpisode;

  const UpdateIsCompletedEvent({
    required this.id,
    required this.totalEpisode,
  });

  @override
  List<Object?> get props => [id, totalEpisode];
}