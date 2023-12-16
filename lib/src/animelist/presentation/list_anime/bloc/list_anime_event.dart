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