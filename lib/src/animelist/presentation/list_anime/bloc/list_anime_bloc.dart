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
    on<UpdateIsCompletedEvent>(_onUpdateIsCompleted);
  }

  void _onAddAnimeEpisode(
    AddAnimeEpisodeEvent event,
    Emitter<ListAnimeState> emit,
  ) async {
    if(event.progressEpisode >= event.totalEpisode) {
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
    }, (_) async {
      var index = getIndexAnimeEntityById(
          listAnime: stateData.uncompletedAnime,
          id: event.id
      );
      stateData.uncompletedAnime[index].progressEpisode++;

      stateData = stateData.copyWith(
        uncompletedAnime: stateData.uncompletedAnime,
        error: null,
      );

      emit(AddAnimeEpisodeSuccessState(stateData));
    });
    //     ?.whenComplete(() async {
    //   var index = getIndexAnimeEntityById(
    //       listAnime: stateData.uncompletedAnime,
    //       id: event.id
    //   );
    //
    //   if(stateData.uncompletedAnime[index].progressEpisode == event.totalEpisode) {
    //     stateData.uncompletedAnime[index].isCompleted = 1;
    //
    //     var resultUpdateIsCompleted = await listAnimeUseCase.updateIsCompletedColumn(
    //       id: event.id,
    //     );
    //
    //     resultUpdateIsCompleted.fold((ErrorDto error) {
    //       stateData = stateData.copyWith(
    //         error: error,
    //       );
    //     }, (_) {
    //       stateData = stateData.copyWith(
    //         uncompletedAnime: stateData.uncompletedAnime,
    //         error: null,
    //       );
    //     });
    //   }
    // });
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
          listAnime: stateData.uncompletedAnime,
          id: event.id
      );
      stateData.uncompletedAnime[index].progressEpisode--;

      stateData = stateData.copyWith(
        uncompletedAnime: stateData.uncompletedAnime,
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
      if(stateData.uncompletedAnime.isEmpty){
        emit(ListAnimeEmptyState(stateData));
      } else{
        emit(ListAnimeSuccessState(stateData));
      }
    }
  }

  void _onUpdateIsCompleted(
    UpdateIsCompletedEvent event,
    Emitter<ListAnimeState> emit,
  ) async {
    emit(UpdateIsCompletedLoadingState(stateData));

    var index = getIndexAnimeEntityById(
      listAnime: stateData.uncompletedAnime,
      id: event.id
    );

    if(stateData.uncompletedAnime[index].progressEpisode == event.totalEpisode) {
      stateData.uncompletedAnime[index].isCompleted = 1;

      var resultUpdateIsCompleted = await listAnimeUseCase.updateIsCompletedColumn(
        id: event.id,
      );

      resultUpdateIsCompleted.fold((ErrorDto error) {
        stateData = stateData.copyWith(
          error: error,
        );
        emit(UpdateIsCompletedFailedState(stateData));
      }, (_) {
        stateData = stateData.copyWith(
          uncompletedAnime: stateData.uncompletedAnime,
          error: null,
        );
        emit(UpdateIsCompletedSuccessState(stateData));
      });
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
      if(tab == 0) {
        stateData = stateData.copyWith(
          uncompletedAnime: right.data ?? [],
          error: null,
        );
      } else if(tab == 1) {
        stateData = stateData.copyWith(
          completedAnime: right.data ?? [],
          error: null,
        );
      }
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