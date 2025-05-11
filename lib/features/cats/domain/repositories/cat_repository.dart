import '../entities/breed.dart';

abstract class CatRepository {
  /// Calls the cat repository API and returns a [List<Breed>].
  /// Throws a [ServerException] for all error codes.
  Future<List<Breed>> getAllCats();
  Future<List<Breed>> getCatsByBreed(String breedId);
}
