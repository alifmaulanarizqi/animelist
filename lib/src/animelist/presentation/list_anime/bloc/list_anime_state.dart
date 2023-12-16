part of 'list_anime_bloc.dart';

class ListAnimeStateData extends Equatable {
  final int? tab;
  final List<AnimeEntity> animeEntity;
  final ErrorDto? error;

  const ListAnimeStateData({
    this.tab = 0,
    this.animeEntity = const [],
    this.error
  });

  @override
  List<Object?> get props => [
    tab,
    animeEntity,
    error
  ];

  ListAnimeStateData copyWith({
    int? tab,
    List<AnimeEntity>? animeEntity,
    ErrorDto? error,
  }) {
    return ListAnimeStateData(
      tab: tab ?? this.tab,
      animeEntity: animeEntity ?? this.animeEntity,
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