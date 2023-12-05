part of 'add_anime_bloc.dart';

class AddAnimeStateData extends Equatable {
  final ErrorDto? error;
  final AnimeEntity? animeEntity;

  const AddAnimeStateData({
    this.error,
    this.animeEntity,
  });

  @override
  List<Object?> get props => [
    error,
    animeEntity,
  ];

  AddAnimeStateData copyWith({
    ErrorDto? error,
    AnimeEntity? animeEntity
  }) {
    return AddAnimeStateData(
      error: error ?? this.error,
      animeEntity: animeEntity ?? this.animeEntity,
    );
  }
}

abstract class AddAnimeState extends Equatable {
  final AddAnimeStateData data;

  const AddAnimeState(this.data);

  @override
  List<Object> get props => [data];
}

class AddAnimeInitialState extends AddAnimeState {
  const AddAnimeInitialState() : super(const AddAnimeStateData());
}

class AddAnimeLoadingState extends AddAnimeState {
  const AddAnimeLoadingState(super.data);
}

class AddAnimeFailedState extends AddAnimeState {
  const AddAnimeFailedState(super.data);
}

class AddAnimeSuccessState extends AddAnimeState {
  const AddAnimeSuccessState(super.data);
}