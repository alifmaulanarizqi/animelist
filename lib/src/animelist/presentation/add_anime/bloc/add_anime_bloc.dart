import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fms/src/animelist/domain/usecase/add_anime_usecase.dart';

import '../../../../../core/data/local/database/entities/anime_entity.dart';
import '../../../../../core/domain/models/error_dto.dart';

part 'add_anime_event.dart';
part 'add_anime_state.dart';

class AddAnimeBloc extends Bloc<AddAnimeEvent, AddAnimeState> {
  final AddAnimeUseCase addAnimeUseCase;
  var stateData = const AddAnimeStateData();

  AddAnimeBloc({required this.addAnimeUseCase})
      : super(const AddAnimeInitialState()) {
    on<AddAnimeInitEvent>(_onInitAddAnime);
  }

  void _onInitAddAnime(
      AddAnimeInitEvent event,
      Emitter<AddAnimeState> emit,
  ) async {
    emit(AddAnimeLoadingState(stateData));

    var result = await addAnimeUseCase.execute(
        animeEntity: event.animeEntity
    );

    result.fold((ErrorDto error) {
      stateData = stateData.copyWith(
        error: error,
      );
      emit(AddAnimeFailedState(stateData));
    }, (detailDto) {
      stateData = stateData.copyWith(
        error: null,
      );

      emit(AddAnimeSuccessState(stateData));
    });
  }
}