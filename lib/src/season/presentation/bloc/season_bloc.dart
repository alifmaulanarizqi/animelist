import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/models/error_dto.dart';
import '../../../search/domain/model/search_dto.dart';
import '../../domain/usecase/season_usecase.dart';

part 'season_event.dart';
part 'season_state.dart';

class SeasonBloc extends Bloc<SeasonEvent, SeasonState> {
  final SeasonUseCase seasonUseCase;
  var stateData = const SeasonStateData();
  bool isLoadingPagination = false;

  SeasonBloc({required this.seasonUseCase})
      : super(const SeasonInitialState()) {
    on<SeasonInitEvent>(_onInitSearch);
    on<GetAnimeLocalEvent>(_onGetAnimeLocal);
  }

  void _onInitSearch(
      SeasonInitEvent event,
      Emitter<SeasonState> emit,
 ) async {
    var hasMoreData =
        stateData.seasonDto.length < stateData.count;
    if (event.page > 1 && !hasMoreData) {
      return;
    }

    if(isLoadingPagination) {
      emit(SeasonPaginationLoadingState(stateData));
    } else {
      emit(SeasonLoadingState(stateData));
    }

    stateData = stateData.copyWith(
      currentPage: event.page,
    );

    await _doSearch(page: event.page);

    if (stateData.error != null) {
      emit(SeasonFailedState(stateData));
    } else {
      if(stateData.seasonDto.isEmpty){
        emit(SeasonEmptyState(stateData));
      } else{
        emit(SeasonSuccessState(stateData));
      }
    }
  }

  void _onGetAnimeLocal(
    GetAnimeLocalEvent event,
    Emitter<SeasonState> emit,
  ) async {
    // emit(GetAnimeLocalLoadingState(stateData));

    var result = await seasonUseCase.getAnimeByMalIdLocal(
      malId: event.malId
    );

    result.fold((ErrorDto error) {
      stateData = stateData.copyWith(
        error: error,
      );
      // emit(GetAnimeLocalFailedState(stateData));
    }, (anime) {
      if(anime.data != null) {
        var index = _getIndexAnimeEntityById(
          listAnime: stateData.seasonDto,
          malId: anime.data?.malId ?? 0
        );

        stateData.seasonDto[index].id = anime.data?.id;
        stateData.seasonDto[index].isInDB = true;
        stateData.seasonDto[index].userScore = anime.data?.score ?? 0;
        stateData.seasonDto[index].progressEpisode = anime.data?.progressEpisode ?? 0;

        stateData = stateData.copyWith(
          error: null,
          seasonDto: stateData.seasonDto,
        );
        emit(GetAnimeLocalSuccessState(stateData));
      } else {
        stateData = stateData.copyWith(
          error: null,
        );
        // emit(GetAnimeLocalNoDataState(stateData));
      }
    });
  }

  Future _doSearch({
    int page = 1,
    int limit = 10,
  }) async {
    stateData = stateData.copyWith(currentPage: page);

    var result = await seasonUseCase.getSeasonNow(
        page: page,
        limit: limit,
    );

    result.fold((ErrorDto error) {
      if (page == 1) {
        stateData = stateData.copyWith(
          seasonDto: [],
          error: error,
        );
      } else {
        stateData = stateData.copyWith(
          error: error,
        );
      }
    }, (right) {
      if (page == 1) {
        stateData = stateData.copyWith(
          total: right.pagination?.items?.total,
          count: right.pagination?.items?.total,
          seasonDto: right.data,
          error: null,
        );
      } else {
        var lastSearchItem = stateData.seasonDto;
        lastSearchItem.addAll(right.data as Iterable<SearchDto>);

        stateData = stateData.copyWith(
          seasonDto: lastSearchItem,
          error: null,
        );
      }
    });
  }

  int _getIndexAnimeEntityById({
    required List<SearchDto> listAnime,
    required int malId,
  }) {
    for (int i = 0; i < listAnime.length; i++) {
      if(listAnime[i].malId == malId) {
        return i;
      }
    }

    return -1;
  }
}