import 'package:fms/src/example/data/remote/services/example_service.dart';
import 'package:fms/src/example/data/repository/example_repository.dart';
import 'package:fms/src/example/data/repository/example_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ExampleDiModule {
  @singleton
  ExampleService exampleService(Dio dio) => ExampleService(dio);

  @Singleton(as: ExampleRepository)
  ExampleRepositoryImpl get exampleRepository;
}
