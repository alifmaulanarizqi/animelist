import 'package:injectable/injectable.dart';
import '../data/repository/animelist_repository.dart';
import '../data/repository/animelist_repository_impl.dart';
import '../domain/usecase/add_anime_usecase.dart';

@module
abstract class AnimelistDiModule {
  @Singleton(as: AnimelistRepository)
  AnimelistRepositoryImpl get animelistRepository;

  @injectable
  AddAnimeUseCase addAnimeUseCase(AnimelistRepository repository) =>
      AddAnimeUseCase(repository);
}