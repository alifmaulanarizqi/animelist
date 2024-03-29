// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i10;
import 'package:fms/core/data/local/app_preferences.dart' as _i9;
import 'package:fms/core/data/local/database/app_database.dart' as _i3;
import 'package:fms/core/data/local/database/dao/anime_dao.dart' as _i7;
import 'package:fms/core/data/remote/interceptors/auth_interceptor.dart' as _i4;
import 'package:fms/core/data/remote/interceptors/cookie_interceptor.dart'
    as _i5;
import 'package:fms/core/di/local_module.dart' as _i22;
import 'package:fms/core/di/network_module.dart' as _i23;
import 'package:fms/src/animelist/data/repository/animelist_repository.dart'
    as _i8;
import 'package:fms/src/animelist/data/repository/animelist_repository_impl.dart'
    as _i25;
import 'package:fms/src/animelist/di/animelist_di_module.dart' as _i24;
import 'package:fms/src/animelist/domain/usecase/add_anime_usecase.dart'
    as _i14;
import 'package:fms/src/animelist/domain/usecase/list_anime_usecase.dart'
    as _i11;
import 'package:fms/src/detail/data/remote/service/detail_service.dart' as _i15;
import 'package:fms/src/detail/data/repository/detail_repository.dart' as _i20;
import 'package:fms/src/detail/data/repository/detail_repository_impl.dart'
    as _i27;
import 'package:fms/src/detail/di/detail_di_module.dart' as _i26;
import 'package:fms/src/detail/domain/usecase/detail_usecase.dart' as _i21;
import 'package:fms/src/search/data/remote/service/search_service.dart' as _i12;
import 'package:fms/src/search/data/repository/search_repository.dart' as _i16;
import 'package:fms/src/search/data/repository/search_repository_impl.dart'
    as _i29;
import 'package:fms/src/search/di/search_di_module.dart' as _i28;
import 'package:fms/src/search/domain/usecase/search_usecase.dart' as _i17;
import 'package:fms/src/season/data/remote/service/season_service.dart' as _i13;
import 'package:fms/src/season/data/repository/season_repository.dart' as _i18;
import 'package:fms/src/season/data/repository/season_repository_impl.dart'
    as _i31;
import 'package:fms/src/season/di/season_di_module.dart' as _i30;
import 'package:fms/src/season/domain/usecase/season_usecase.dart' as _i19;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

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
    final localModule = _$LocalModule();
    final networkModule = _$NetworkModule();
    final animelistDiModule = _$AnimelistDiModule(this);
    final searchDiModule = _$SearchDiModule(this);
    final seasonDiModule = _$SeasonDiModule(this);
    final detailDiModule = _$DetailDiModule(this);
    await gh.singletonAsync<_i3.AppDatabase>(
      () => localModule.appDatabase(),
      preResolve: true,
    );
    gh.singleton<_i4.AuthInterceptor>(networkModule.authInterceptor);
    gh.singleton<_i5.CookieInterceptor>(networkModule.cookieInterceptor);
    await gh.singletonAsync<_i6.SharedPreferences>(
      () => localModule.prefs,
      preResolve: true,
    );
    gh.singleton<String>(
      networkModule.baseUrl,
      instanceName: 'base_url',
    );
    gh.singleton<_i7.AnimeDao>(localModule.animeDao(gh<_i3.AppDatabase>()));
    gh.singleton<_i8.AnimelistRepository>(
        animelistDiModule.animelistRepository);
    gh.singleton<_i9.AppPreferences>(
        localModule.appPreferences(gh<_i6.SharedPreferences>()));
    gh.singleton<_i10.Dio>(networkModule.dio(
      gh<String>(instanceName: 'base_url'),
      gh<_i4.AuthInterceptor>(),
      gh<_i5.CookieInterceptor>(),
    ));
    gh.factory<_i11.ListAnimeUseCase>(() =>
        animelistDiModule.listAnimeUseCase(gh<_i8.AnimelistRepository>()));
    gh.singleton<_i12.SearchService>(
        searchDiModule.searchService(gh<_i10.Dio>()));
    gh.singleton<_i13.SeasonService>(
        seasonDiModule.seasonService(gh<_i10.Dio>()));
    gh.factory<_i14.AddAnimeUseCase>(
        () => animelistDiModule.addAnimeUseCase(gh<_i8.AnimelistRepository>()));
    gh.singleton<_i15.DetailService>(
        detailDiModule.detailService(gh<_i10.Dio>()));
    gh.singleton<_i16.SearchRepository>(searchDiModule.searchRepository);
    gh.factory<_i17.SearchUseCase>(
        () => searchDiModule.searchUseCase(gh<_i16.SearchRepository>()));
    gh.singleton<_i18.SeasonRepository>(seasonDiModule.seasonRepository);
    gh.factory<_i19.SeasonUseCase>(
        () => seasonDiModule.seasonUseCase(gh<_i18.SeasonRepository>()));
    gh.singleton<_i20.DetailRepository>(detailDiModule.searchRepository);
    gh.factory<_i21.DetailUseCase>(
        () => detailDiModule.detailUseCase(gh<_i20.DetailRepository>()));
    return this;
  }
}

class _$LocalModule extends _i22.LocalModule {}

class _$NetworkModule extends _i23.NetworkModule {}

class _$AnimelistDiModule extends _i24.AnimelistDiModule {
  _$AnimelistDiModule(this._getIt);

  final _i1.GetIt _getIt;

  @override
  _i25.AnimelistRepositoryImpl get animelistRepository =>
      _i25.AnimelistRepositoryImpl(_getIt<_i7.AnimeDao>());
}

class _$DetailDiModule extends _i26.DetailDiModule {
  _$DetailDiModule(this._getIt);

  final _i1.GetIt _getIt;

  @override
  _i27.DetailRepositoryImpl get searchRepository => _i27.DetailRepositoryImpl(
        _getIt<_i15.DetailService>(),
        _getIt<_i7.AnimeDao>(),
      );
}

class _$SearchDiModule extends _i28.SearchDiModule {
  _$SearchDiModule(this._getIt);

  final _i1.GetIt _getIt;

  @override
  _i29.SearchRepositoryImpl get searchRepository => _i29.SearchRepositoryImpl(
        _getIt<_i12.SearchService>(),
        _getIt<_i7.AnimeDao>(),
      );
}

class _$SeasonDiModule extends _i30.SeasonDiModule {
  _$SeasonDiModule(this._getIt);

  final _i1.GetIt _getIt;

  @override
  _i31.SeasonRepositoryImpl get seasonRepository => _i31.SeasonRepositoryImpl(
        _getIt<_i13.SeasonService>(),
        _getIt<_i7.AnimeDao>(),
      );
}
