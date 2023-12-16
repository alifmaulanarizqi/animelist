part of 'add_anime_bloc.dart';

abstract class AddAnimeEvent extends Equatable {
  const AddAnimeEvent();
}

class AddAnimeSubmitEvent extends AddAnimeEvent {
  final AnimeEntity animeEntity;

  const AddAnimeSubmitEvent({
    required this.animeEntity
  });

  @override
  List<Object?> get props => [animeEntity];
}

class UpdateAnimeSubmitEvent extends AddAnimeEvent {
  final AnimeEntity animeEntity;

  const UpdateAnimeSubmitEvent({
    required this.animeEntity
  });

  @override
  List<Object?> get props => [animeEntity];
}

class DeleteAnimeSubmitEvent extends AddAnimeEvent {
  final AnimeEntity animeEntity;

  const DeleteAnimeSubmitEvent({
    required this.animeEntity
  });

  @override
  List<Object?> get props => [animeEntity];
}