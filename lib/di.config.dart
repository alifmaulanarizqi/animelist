// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i7;
import 'package:fms/core/data/local/app_preferences.dart' as _i6;
import 'package:fms/core/data/remote/interceptors/auth_interceptor.dart' as _i3;
import 'package:fms/core/data/remote/interceptors/cookie_interceptor.dart'
    as _i4;
import 'package:fms/core/di/local_module.dart' as _i16;
import 'package:fms/core/di/network_module.dart' as _i17;
import 'package:fms/src/example/data/remote/services/example_service.dart'
    as _i8;
import 'package:fms/src/example/data/repository/example_repository.dart'
    as _i11;
import 'package:fms/src/example/data/repository/example_repository_impl.dart'
    as _i19;
import 'package:fms/src/example/di/example_di_module.dart' as _i18;
import 'package:fms/src/search/data/remote/service/search_service.dart' as _i9;
import 'package:fms/src/search/data/repository/search_repository.dart' as _i12;
import 'package:fms/src/search/data/repository/search_repository_impl.dart'
    as _i21;
import 'package:fms/src/search/di/search_di_module.dart' as _i20;
import 'package:fms/src/search/domain/usecase/search_usecase.dart' as _i13;
import 'package:fms/src/season/data/remote/service/season_service.dart' as _i10;
import 'package:fms/src/season/data/repository/season_repository.dart' as _i14;
import 'package:fms/src/season/data/repository/season_repository_impl.dart'
    as _i23;
import 'package:fms/src/season/di/season_di_module.dart' as _i22;
import 'package:fms/src/season/domain/usecase/season_usecase.dart' as _i15;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i5;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final networkModule = _$NetworkModule();
    final localModule = _$LocalModule();
    final exampleDiModule = _$ExampleDiModule(this);
    final searchDiModule = _$SearchDiModule(this);
    final seasonDiModule = _$SeasonDiModule(this);
    gh.singleton<_i3.AuthInterceptor>(networkModule.authInterceptor);
    gh.singleton<_i4.CookieInterceptor>(networkModule.cookieInterceptor);
    await gh.singletonAsync<_i5.SharedPreferences>(
      () => localModule.prefs,
      preResolve: true,
    );
    gh.singleton<String>(
      networkModule.baseUrl,
      instanceName: 'base_url',
    );
    gh.singleton<_i6.AppPreferences>(
        localModule.appPreferences(gh<_i5.SharedPreferences>()));
    gh.singleton<_i7.Dio>(networkModule.dio(
      gh<String>(instanceName: 'base_url'),
      gh<_i3.AuthInterceptor>(),
      gh<_i4.CookieInterceptor>(),
    ));
    gh.singleton<_i8.ExampleService>(
        exampleDiModule.exampleService(gh<_i7.Dio>()));
    gh.singleton<_i9.SearchService>(
        searchDiModule.searchService(gh<_i7.Dio>()));
    gh.singleton<_i10.SeasonService>(
        seasonDiModule.seasonService(gh<_i7.Dio>()));
    gh.singleton<_i11.ExampleRepository>(exampleDiModule.exampleRepository);
    gh.singleton<_i12.SearchRepository>(searchDiModule.searchRepository);
    gh.factory<_i13.SearchUseCase>(
        () => searchDiModule.searchUseCase(gh<_i12.SearchRepository>()));
    gh.singleton<_i14.SeasonRepository>(seasonDiModule.seasonRepository);
    gh.factory<_i15.SeasonUseCase>(
        () => seasonDiModule.seasonUseCase(gh<_i14.SeasonRepository>()));
    return this;
  }
}

class _$LocalModule extends _i16.LocalModule {}

class _$NetworkModule extends _i17.NetworkModule {}

class _$ExampleDiModule extends _i18.ExampleDiModule {
  _$ExampleDiModule(this._getIt);

  final _i1.GetIt _getIt;

  @override
  _i19.ExampleRepositoryImpl get exampleRepository =>
      _i19.ExampleRepositoryImpl(_getIt<_i8.ExampleService>());
}

class _$SearchDiModule extends _i20.SearchDiModule {
  _$SearchDiModule(this._getIt);

  final _i1.GetIt _getIt;

  @override
  _i21.SearchRepositoryImpl get searchRepository =>
      _i21.SearchRepositoryImpl(_getIt<_i9.SearchService>());
}

class _$SeasonDiModule extends _i22.SeasonDiModule {
  _$SeasonDiModule(this._getIt);

  final _i1.GetIt _getIt;

  @override
  _i23.SeasonRepositoryImpl get seasonRepository =>
      _i23.SeasonRepositoryImpl(_getIt<_i10.SeasonService>());
}
