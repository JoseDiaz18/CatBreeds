import '../entities/breed.dart';
import '../repositories/cat_repository.dart';

class GetBreedsUseCase {
  final CatRepository repository;

  GetBreedsUseCase({required this.repository});

  Future<List<Breed>> call() async {
    return await repository.getAllCats();
  }
}
