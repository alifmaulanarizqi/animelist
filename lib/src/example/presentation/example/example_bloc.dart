import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/domain/models/error_dto.dart';
import '../../../../../../core/domain/models/key_value_dto.dart';
import '../../domain/models/example_dto.dart';
import '../../domain/usecases/example_usecase.dart';

part 'example_event.dart';
part 'example_state.dart';

class ExampleBloc
    extends Bloc<ExampleEvent, ExampleState> {
  final ExampleUseCase exampleUseCase;
  var stateData = const ExampleStateData();

  ExampleBloc({required this.exampleUseCase})
      : super(const ExampleInitialState()) {
    on<ExampleInitEvent>(_onInitRecipe);
  }

  void _onInitRecipe(
      ExampleInitEvent event,
      Emitter<ExampleState> emit,
  ) async {
    emit(ExampleLoadingState(stateData));

    await _doSearch(apiKey: event.apiKey);

    if (stateData.error != null) {
      emit(ExampleFailedState(stateData));
    } else {
      if(stateData.exampleDto.isEmpty){
        emit(ExampleEmptyState(stateData));
      } else{
        emit(ExampleSuccessState(stateData));
      }
    }
  }

  Future _doSearch({
    String? apiKey,
  }) async {
    var result = await exampleUseCase.execute(
      apiKey: apiKey
    );

    result.fold((ErrorDto error) {
      print('adshiuwhdiuwedwaaaa ${error.errorCode}, ${error.errorType}');
      stateData = stateData.copyWith(
        exampleDto: [],
        error: error,
      );
    }, (right) {
      // List<ExampleDto> exampleRecipe = [];
      // exampleRecipe = stateData.exampleDto;
      // exampleRecipe.addAll(right.results);

      stateData = stateData.copyWith(
        exampleDto: right.results,
        error: null,
      );
    });
  }
}
