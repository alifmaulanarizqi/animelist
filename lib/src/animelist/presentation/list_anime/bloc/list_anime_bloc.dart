import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/data/local/database/entities/anime_entity.dart';
import '../../../../../core/domain/models/error_dto.dart';
import '../../../domain/usecase/list_anime_usecase.dart';

part 'list_anime_event.dart';
part 'list_anime_state.dart';

class ListAnimeBloc extends Bloc<ListAnimeEvent, ListAnimeState> {
  final ListAnimeUseCase listAnimeUseCase;
  var stateData = const ListAnimeStateData();
  bool isFirstLoadingUncompleted = true;
  bool isFirstLoadingCompleted = true;

  ListAnimeBloc({
    required this.listAnimeUseCase,
  }) : super(const ListAnimeInitialState()) {
    on<ListAnimeInitEvent>(_onInitListAnime);
    on<AddAnimeEpisodeEvent>(_onAddAnimeEpisode);
    on<ReduceAnimeEpisodeEvent>(_onReduceAnimeEpisode);
  }

  void _onAddAnimeEpisode(
    AddAnimeEpisodeEvent event,
    Emitter<ListAnimeState> emit,
  ) async {
    if(event.progressEpisode == 0) {
      return;
    }

    emit(AddAnimeEpisodeLoadingState(stateData));

    var result = await listAnimeUseCase.addAnimeEpisode(
      id: event.id,
    );

    result.fold((ErrorDto error) {
      stateData = stateData.copyWith(
        error: error,
      );
      emit(AddAnimeEpisodeFailedState(stateData));
    }, (_) {
      var index = getIndexAnimeEntityById(
          listAnime: stateData.animeEntity,
          id: event.id
      );
      stateData.animeEntity[index].progressEpisode++;

      stateData = stateData.copyWith(
        animeEntity: stateData.animeEntity,
        error: null,
      );

      emit(AddAnimeEpisodeSuccessState(stateData));
    });
  }

  void _onReduceAnimeEpisode(
    ReduceAnimeEpisodeEvent event,
    Emitter<ListAnimeState> emit,
  ) async {
    if(event.progressEpisode == 0) {
      return;
    }

    emit(ReduceAnimeEpisodeLoadingState(stateData));

    var result = await listAnimeUseCase.reduceAnimeEpisode(
      id: event.id,
    );

    result.fold((ErrorDto error) {
      stateData = stateData.copyWith(
        error: error,
      );
      emit(ReduceAnimeEpisodeFailedState(stateData));
    }, (_) {
      var index = getIndexAnimeEntityById(
          listAnime: stateData.animeEntity,
          id: event.id
      );
      stateData.animeEntity[index].progressEpisode--;

      stateData = stateData.copyWith(
        animeEntity: stateData.animeEntity,
        error: null,
      );

      stateData = stateData.copyWith(
        error: null,
      );

      emit(ReduceAnimeEpisodeSuccessState(stateData));
    });
  }

  void _onInitListAnime(
    ListAnimeInitEvent event,
    Emitter<ListAnimeState> emit,
  ) async {
    stateData = stateData.copyWith(
      tab: event.tab,
    );

    emit(ListAnimeLoadingState(stateData));

    await _doSearch(
      tab: stateData.tab
    );

    if(stateData.tab == 0) {
      isFirstLoadingUncompleted = false;
    } else {
      isFirstLoadingCompleted = false;
    }

    if (stateData.error != null) {
      emit(ListAnimeFailedState(stateData));
    } else {
      if(stateData.animeEntity.isEmpty){
        emit(ListAnimeEmptyState(stateData));
      } else{
        emit(ListAnimeSuccessState(stateData));
      }
    }
  }

  Future _doSearch({
    int? tab,
  }) async {
    var result = await listAnimeUseCase.getAnimeList(
      tab: tab,
    );

    result.fold((ErrorDto error) {
      stateData = stateData.copyWith(
        error: error,
      );
    }, (right) {
      stateData = stateData.copyWith(
        animeEntity: right.data ?? [],
        error: null,
      );
    });
  }

  int getIndexAnimeEntityById({
    required List<AnimeEntity> listAnime,
    required int id,
  }) {
    for (int i = 0; i < listAnime.length; i++) {
      if(listAnime[i].id == id) {
        return i;
      }
    }

    return -1;
  }
}