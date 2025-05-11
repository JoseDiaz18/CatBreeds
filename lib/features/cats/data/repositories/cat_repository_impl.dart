import '../../domain/entities/breed.dart';
import '../datasources/cat_remote_data_source.dart';
import '../../domain/repositories/cat_repository.dart';

class CatRepositoryImpl implements CatRepository {
  final CatRemoteDataSource remoteDataSource;

  CatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Breed>> getAllCats() async {
    final breeds = await remoteDataSource.getAllBreeds();
    if (breeds.isEmpty) {
      throw Exception('No breeds found');
    }
    return breeds.map((json) => json.toEntity()).toList();
  }

  @override
  Future<List<Breed>> getCatsByBreed(String breedId) async {
    final breeds = await remoteDataSource.getCatsByBreed(breedId);
    if (breeds.isEmpty) {
      throw Exception('Breed ID cannot be empty');
    }
    return breeds.map((json) => json.toEntity()).toList();
  }
}
