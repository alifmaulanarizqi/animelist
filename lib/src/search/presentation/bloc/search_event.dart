part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchInitEvent extends SearchEvent {
  final int page;
  final String? q;

  const SearchInitEvent({
    required this.page,
    this.q = '',
  });

  @override
  List<Object?> get props => [page, q];
}

class GetAnimeLocalEvent extends SearchEvent {
  final int malId;

  const GetAnimeLocalEvent({
    required this.malId,
  });

  @override
  List<Object?> get props => [malId];
}
