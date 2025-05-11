import '../entities/breed.dart';
import '../repositories/cat_repository.dart';

class GetByBreedsUseCase {
  final CatRepository repository;

  GetByBreedsUseCase({required this.repository});

  Future<List<Breed>> call(String breed) async {
    return await repository.getCatsByBreed(breed);
  }
}
