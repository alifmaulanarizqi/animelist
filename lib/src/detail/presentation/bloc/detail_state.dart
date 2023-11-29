part of 'detail_bloc.dart';

class DetailStateData extends Equatable {
  final DetailDto detailDto;
  final ErrorDto? error;

  const DetailStateData({
    this.detailDto = const DetailDto(),
    this.error
  });

  @override
  List<Object?> get props => [
    detailDto,
    error
  ];

  DetailStateData copyWith({
    DetailDto? detailDto,
    ErrorDto? error,
  }) {
    return DetailStateData(
      detailDto: detailDto ?? this.detailDto,
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