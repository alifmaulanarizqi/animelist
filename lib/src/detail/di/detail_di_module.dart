import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../data/remote/service/detail_service.dart';
import '../data/repository/detail_repository.dart';
import '../data/repository/detail_repository_impl.dart';
import '../domain/usecase/detail_usecase.dart';

@module
abstract class DetailDiModule {
  @singleton
  DetailService detailService(Dio dio) => DetailService(dio);

  @Singleton(as: DetailRepository)
  DetailRepositoryImpl get searchRepository;

  @injectable
  DetailUseCase detailUseCase(DetailRepository repository) =>
      DetailUseCase(repository);
}