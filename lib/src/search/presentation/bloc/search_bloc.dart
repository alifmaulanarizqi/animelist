import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fms/src/search/domain/usecase/search_usecase.dart';

import '../../../../core/domain/models/error_dto.dart';
import '../../domain/model/search_dto.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUseCase searchUseCase;
  var stateData = const SearchStateData();
  bool isLoadingPagination = false;

  SearchBloc({required this.searchUseCase})
      : super(const SearchInitialState()) {
    on<SearchInitEvent>(_onInitSearch);
  }

  void _onInitSearch(
      SearchInitEvent event,
      Emitter<SearchState> emit,
  ) async {
    var hasMoreData =
        stateData.searchDto.length < stateData.count;
    if (event.page > 1 && !hasMoreData) {
      return;
    }

    if(isLoadingPagination) {
      emit(SearchPaginationLoadingState(stateData));
    } else {
      emit(SearchLoadingState(stateData));
    }

    stateData = stateData.copyWith(
      currentPage: event.page,
    );

    await _doSearch(page: event.page, q: event.q);

    if (stateData.error != null) {
      emit(SearchFailedState(stateData));
    } else {
      if(stateData.searchDto.isEmpty){
        emit(SearchEmptyState(stateData));
      } else{
        emit(SearchSuccessState(stateData));
      }
    }
  }

  Future _doSearch({
    int page = 1,
    int limit = 10,
    String? q,
  }) async {
    stateData = stateData.copyWith(currentPage: page);

    var result = await searchUseCase.execute(
        page: page,
        limit: limit,
        q: q
    );

    result.fold((ErrorDto error) {
      if (page == 1) {
        stateData = stateData.copyWith(
          searchDto: [],
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
          searchDto: right.data,
          error: null,
        );
      } else {
        var lastSearchItem = stateData.searchDto;
        lastSearchItem.addAll(right.data as Iterable<SearchDto>);

        stateData = stateData.copyWith(
          searchDto: lastSearchItem,
          error: null,
        );
      }
    });
  }
}
