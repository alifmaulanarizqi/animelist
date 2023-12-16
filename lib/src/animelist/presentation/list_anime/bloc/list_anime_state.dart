part of 'list_anime_bloc.dart';

class ListAnimeStateData extends Equatable {
  final int? tab;
  final List<AnimeEntity> uncompletedAnime;
  final List<AnimeEntity> completedAnime;
  final ErrorDto? error;

  const ListAnimeStateData({
    this.tab = 0,
    this.uncompletedAnime = const [],
    this.completedAnime = const [],
    this.error
  });

  @override
  List<Object?> get props => [
    tab,
    uncompletedAnime,
    completedAnime,
    error
  ];

  ListAnimeStateData copyWith({
    int? tab,
    List<AnimeEntity>? uncompletedAnime,
    List<AnimeEntity>? completedAnime,
    ErrorDto? error,
  }) {
    return ListAnimeStateData(
      tab: tab ?? this.tab,
      uncompletedAnime: uncompletedAnime ?? this.uncompletedAnime,
      completedAnime: completedAnime ?? this.completedAnime,
      error: error ?? this.error,
    );
  }
}

abstract class ListAnimeState extends Equatable {
  final ListAnimeStateData data;

  const ListAnimeState(this.data);

  @override
  List<Object> get props => [];
}

class ListAnimeInitialState extends ListAnimeState {
  const ListAnimeInitialState()
      : super(const ListAnimeStateData());
}

class ListAnimeLoadingState extends ListAnimeState {
  const ListAnimeLoadingState(super.data);
}

class ListAnimeFailedState extends ListAnimeState {
  const ListAnimeFailedState(super.data);
}

class ListAnimeSuccessState extends ListAnimeState {
  const ListAnimeSuccessState(super.data);
}

class ListAnimeEmptyState extends ListAnimeState {
  const ListAnimeEmptyState(super.data);
}

class AddAnimeEpisodeLoadingState extends ListAnimeState {
  const AddAnimeEpisodeLoadingState(super.data);
}

class AddAnimeEpisodeSuccessState extends ListAnimeState {
  const AddAnimeEpisodeSuccessState(super.data);
}

class AddAnimeEpisodeFailedState extends ListAnimeState {
  const AddAnimeEpisodeFailedState(super.data);
}

class ReduceAnimeEpisodeLoadingState extends ListAnimeState {
  const ReduceAnimeEpisodeLoadingState(super.data);
}

class ReduceAnimeEpisodeSuccessState extends ListAnimeState {
  const ReduceAnimeEpisodeSuccessState(super.data);
}

class ReduceAnimeEpisodeFailedState extends ListAnimeState {
  const ReduceAnimeEpisodeFailedState(super.data);
}

class UpdateIsCompletedLoadingState extends ListAnimeState {
  const UpdateIsCompletedLoadingState(super.data);
}

class UpdateIsCompletedSuccessState extends ListAnimeState {
  const UpdateIsCompletedSuccessState(super.data);
}

class UpdateIsCompletedFailedState extends ListAnimeState {
  const UpdateIsCompletedFailedState(super.data);
}