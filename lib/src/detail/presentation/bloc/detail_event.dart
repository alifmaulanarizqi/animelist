part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();
}

class DetailInitEvent extends DetailEvent {
  final int id;

  const DetailInitEvent({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}