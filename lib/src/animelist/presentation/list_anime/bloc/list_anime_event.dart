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

  const AddAnimeEpisodeEvent({
    required this.id,
    required this.progressEpisode,
  });

  @override
  List<Object?> get props => [id, progressEpisode];
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