part of 'example_bloc.dart';

class ExampleStateData extends Equatable {
  final List<ExampleDto> exampleDto;
  final ErrorDto? error;

  const ExampleStateData({
    this.exampleDto = const [],
    this.error
  });

  @override
  List<Object?> get props => [
    exampleDto,
    error
  ];

  ExampleStateData copyWith({
    List<ExampleDto>? exampleDto,
    ErrorDto? error,
  }) {
    return ExampleStateData(
      exampleDto: exampleDto ?? this.exampleDto,
      error: error ?? this.error,
    );
  }
}

abstract class ExampleState extends Equatable {
  final ExampleStateData data;

  const ExampleState(this.data);

  @override
  List<Object> get props => [];
}

class ExampleInitialState extends ExampleState {
  const ExampleInitialState()
      : super(const ExampleStateData());
}

class ExampleLoadingState extends ExampleState {
  const ExampleLoadingState(super.data);
}

class ExampleFailedState extends ExampleState {
  const ExampleFailedState(super.data);
}

class ExampleSuccessState extends ExampleState {
  const ExampleSuccessState(super.data);
}

class ExampleEmptyState extends ExampleState {
  const ExampleEmptyState(super.data);
}
