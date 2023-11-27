part of 'season_bloc.dart';

abstract class SeasonEvent extends Equatable {
  const SeasonEvent();
}

class SeasonInitEvent extends SeasonEvent {
  final int page;

  const SeasonInitEvent({
    required this.page,
  });

  @override
  List<Object?> get props => [page];
}