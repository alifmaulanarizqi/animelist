part of 'detail_bloc.dart';

class DetailStateData extends Equatable {
  final DetailDto? detailDto;
  final AnimeEntity? animeEntity;
  final ErrorDto? error;

  const DetailStateData({
    this.detailDto = const DetailDto(),
    this.animeEntity,
    this.error
  });

  @override
  List<Object?> get props => [
    detailDto,
    animeEntity,
    error
  ];

  DetailStateData copyWith({
    DetailDto? detailDto,
    AnimeEntity? animeEntity,
    ErrorDto? error,
  }) {
    return DetailStateData(
      detailDto: detailDto ?? this.detailDto,
      animeEntity: animeEntity ?? this.animeEntity,
      error: error ?? this.error,
    );
  }
}

abstract class DetailState extends Equatable {
  final DetailStateData data;

  const DetailState(this.data);

  @override
  List<Object> get props => [];
}

class DetailInitialState extends DetailState {
  const DetailInitialState()
      : super(const DetailStateData());
}

class DetailLoadingState extends DetailState {
  const DetailLoadingState(super.data);
}

class DetailFailedState extends DetailState {
  const DetailFailedState(super.data);
}

class DetailSuccessState extends DetailState {
  const DetailSuccessState(super.data);
}

class GetAnimeLocalLoadingState extends DetailState {
  const GetAnimeLocalLoadingState(super.data);
}

class GetAnimeLocalFailedState extends DetailState {
  const GetAnimeLocalFailedState(super.data);
}

class GetAnimeLocalSuccessState extends DetailState {
  const GetAnimeLocalSuccessState(super.data);
}