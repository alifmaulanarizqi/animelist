part of 'season_bloc.dart';

class SeasonStateData extends Equatable {
  final int currentPage;
  final int count;
  final int total;
  final List<SearchDto> seasonDto;

  final ErrorDto? error;

  const SeasonStateData({
    this.currentPage = 1,
    this.count = 10,
    this.total = 0,
    this.seasonDto = const [],
    this.error
  });

  @override
  List<Object?> get props => [
    currentPage,
    count,
    total,
    seasonDto,
    error
  ];

  SeasonStateData copyWith({
    int? currentPage,
    int? count,
    int? total,
    List<SearchDto>? seasonDto,
    ErrorDto? error,
  }) {
    return SeasonStateData(
      currentPage: currentPage ?? this.currentPage,
      count: count ?? this.count,
      total: total ?? this.total,
      seasonDto: seasonDto ?? this.seasonDto,
      error: error ?? this.error,
    );
  }
}

abstract class SeasonState extends Equatable {
  final SeasonStateData data;

  const SeasonState(this.data);

  @override
  List<Object> get props => [];
}

class SeasonInitialState extends SeasonState {
  const SeasonInitialState()
      : super(const SeasonStateData());
}

class SeasonLoadingState extends SeasonState {
  const SeasonLoadingState(super.data);
}

class SeasonPaginationLoadingState extends SeasonState {
  const SeasonPaginationLoadingState(super.data);
}

class SeasonFailedState extends SeasonState {
  const SeasonFailedState(super.data);
}

class SeasonSuccessState extends SeasonState {
  const SeasonSuccessState(super.data);
}

class SeasonEmptyState extends SeasonState {
  const SeasonEmptyState(super.data);
}