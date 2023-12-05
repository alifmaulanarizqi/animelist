part of 'example_bloc.dart';

abstract class ExampleEvent extends Equatable {
  const ExampleEvent();
}

class ExampleInitEvent extends ExampleEvent {
  final String? apiKey;

  const ExampleInitEvent({
    required this.apiKey,
  });

  @override
  List<Object?> get props => [apiKey];
}
