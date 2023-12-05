part of 'add_anime_bloc.dart';

abstract class AddAnimeEvent extends Equatable {
  const AddAnimeEvent();
}

class AddAnimeInitEvent extends AddAnimeEvent {
  final AnimeEntity animeEntity;

  const AddAnimeInitEvent({
    required this.animeEntity
  });

  @override
  List<Object?> get props => [animeEntity];
}

class AddAnimeSubmitEvent extends AddAnimeEvent {
  @override
  List<Object?> get props => [];
}