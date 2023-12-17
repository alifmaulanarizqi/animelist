part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();
}

class DetailInitEvent extends DetailEvent {
  final int malId;

  const DetailInitEvent({
    required this.malId,
  });

  @override
  List<Object?> get props => [malId];
}

class GetAnimeLocalEvent extends DetailEvent {
  final int malId;

  const GetAnimeLocalEvent({
    required this.malId,
  });

  @override
  List<Object?> get props => [malId];
}