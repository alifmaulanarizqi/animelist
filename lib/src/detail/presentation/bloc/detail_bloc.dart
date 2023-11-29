import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/models/error_dto.dart';
import '../../domain/model/detail_dto.dart';
import '../../domain/usecase/detail_usecase.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final DetailUseCase detailUseCase;
  var stateData = const DetailStateData();

  DetailBloc({required this.detailUseCase})
      : super(const DetailInitialState()) {
    on<DetailInitEvent>(_onInitDetail);
  }

  void _onInitDetail(
      DetailInitEvent event,
      Emitter<DetailState> emit,
  ) async {
    emit(DetailLoadingState(stateData));

    var result = await detailUseCase.execute(
      id: event.id
    );

    result.fold((ErrorDto error) {
      stateData = stateData.copyWith(
        detailDto: const DetailDto(),
        error: error,
      );
      emit(DetailFailedState(stateData));
    }, (detailDto) {
      stateData = stateData.copyWith(
        detailDto: detailDto.data,
        error: null,
      );

      emit(DetailSuccessState(stateData));
    });
  }
}