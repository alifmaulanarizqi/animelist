part of 'search_bloc.dart';

class SearchStateData extends Equatable {
  final int currentPage;
  final int count;
  final int total;
  final List<SearchDto> searchDto;

  final ErrorDto? error;

  const SearchStateData({
    this.currentPage = 1,
    this.count = 10,
    this.total = 0,
    this.searchDto = const [],
    this.error
  });

  @override
  List<Object?> get props => [
    currentPage,
    count,
    total,
    searchDto,
    error
  ];

  SearchStateData copyWith({
    int? currentPage,
    int? count,
    int? total,
    List<SearchDto>? searchDto,
    ErrorDto? error,
  }) {
    return SearchStateData(
      currentPage: currentPage ?? this.currentPage,
      count: count ?? this.count,
      total: total ?? this.total,
      searchDto: searchDto ?? this.searchDto,
      error: error ?? this.error,
    );
  }
}

abstract class SearchState extends Equatable {
  final SearchStateData data;

  const SearchState(this.data);

  @override
  List<Object> get props => [];
}

class SearchInitialState extends SearchState {
  const SearchInitialState()
      : super(const SearchStateData());
}

class SearchLoadingState extends SearchState {
  const SearchLoadingState(super.data);
}

class SearchPaginationLoadingState extends SearchState {
  const SearchPaginationLoadingState(super.data);
}

class SearchFailedState extends SearchState {
  const SearchFailedState(super.data);
}

class SearchSuccessState extends SearchState {
  const SearchSuccessState(super.data);
}

class SearchEmptyState extends SearchState {
  const SearchEmptyState(super.data);
}
