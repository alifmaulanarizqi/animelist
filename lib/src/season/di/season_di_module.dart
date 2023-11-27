import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../data/remote/service/season_service.dart';
import '../data/repository/season_repository.dart';
import '../data/repository/season_repository_impl.dart';
import '../domain/usecase/season_usecase.dart';

@module
abstract class SeasonDiModule {
  @singleton
  SeasonService seasonService(Dio dio) => SeasonService(dio);

  @Singleton(as: SeasonRepository)
  SeasonRepositoryImpl get seasonRepository;

  @injectable
  SeasonUseCase seasonUseCase(SeasonRepository repository) =>
      SeasonUseCase(repository);
}