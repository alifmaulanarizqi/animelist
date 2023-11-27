import 'package:dio/dio.dart';
import 'package:fms/src/search/data/remote/service/search_service.dart';
import 'package:fms/src/search/data/repository/search_repository.dart';
import 'package:fms/src/search/domain/usecase/search_usecase.dart';
import 'package:injectable/injectable.dart';

import '../data/repository/search_repository_impl.dart';

@module
abstract class SearchDiModule {
  @singleton
  SearchService searchService(Dio dio) => SearchService(dio);

  @Singleton(as: SearchRepository)
  SearchRepositoryImpl get searchRepository;

  @injectable
  SearchUseCase searchUseCase(SearchRepository repository) =>
      SearchUseCase(repository);
}