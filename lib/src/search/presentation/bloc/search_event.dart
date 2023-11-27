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
