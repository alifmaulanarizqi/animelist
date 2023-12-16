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
    on<AddAnimeSubmitEvent>(_onAddAnime);
    on<UpdateAnimeSubmitEvent>(_onUpdateAnime);
    on<DeleteAnimeSubmitEvent>(_onDeleteAnime);
  }

  void _onAddAnime(
      AddAnimeSubmitEvent event,
      Emitter<AddAnimeState> emit,
  ) async {
    emit(AddAnimeLoadingState(stateData));

    var result = await addAnimeUseCase.insert(
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

  void _onUpdateAnime(
      UpdateAnimeSubmitEvent event,
      Emitter<AddAnimeState> emit,
  ) async {
    emit(UpdateAnimeLoadingState(stateData));

    var result = await addAnimeUseCase.update(
        animeEntity: event.animeEntity
    );

    result.fold((ErrorDto error) {
      stateData = stateData.copyWith(
        error: error,
      );
      emit(UpdateAnimeFailedState(stateData));
    }, (detailDto) {
      stateData = stateData.copyWith(
        error: null,
      );

      emit(UpdateAnimeSuccessState(stateData));
    });
  }

  void _onDeleteAnime(
      DeleteAnimeSubmitEvent event,
      Emitter<AddAnimeState> emit,
  ) async {
    emit(DeleteAnimeLoadingState(stateData));

    var result = await addAnimeUseCase.delete(
        animeEntity: event.animeEntity
    );

    result.fold((ErrorDto error) {
      stateData = stateData.copyWith(
        error: error,
      );
      emit(DeleteAnimeFailedState(stateData));
    }, (detailDto) {
      stateData = stateData.copyWith(
        error: null,
      );

      emit(DeleteAnimeSuccessState(stateData));
    });
  }
}