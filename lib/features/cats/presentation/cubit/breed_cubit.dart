import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/breed.dart';
import 'breed_state.dart';
import '../../domain/repositories/cat_repository.dart';

class BreedCubit extends Cubit<BreedState> {
  final CatRepository repository;
  List<Breed> _allBreeds = [];
  List<Breed> _filteredBreeds = [];

  BreedCubit({required this.repository}) : super(BreedInitial());

  Future<void> fetchBreeds() async {
    emit(BreedLoading());
    try {
      final breeds = await repository.getAllCats();
      _allBreeds = breeds;
      _filteredBreeds = breeds;
      emit(BreedLoaded(breeds: breeds));
    } catch (e) {
      emit(
        BreedError(
          message: 'Error al obtener las razas de gatos: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> fetchCatsByBreed(String breedId) async {
    emit(BreedLoading());
    try {
      final breeds = await repository.getCatsByBreed(breedId);
      emit(BreedLoaded(breeds: breeds));
    } catch (e) {
      emit(
        BreedError(
          message: 'Error al obtener los gatos de la raza: ${e.toString()}',
        ),
      );
    }
  }

  void filterBreeds(String query) {
    if (query.isEmpty) {
      _filteredBreeds = _allBreeds;
    } else {
      final lowerCaseQuery = query.toLowerCase();
      _filteredBreeds =
          _allBreeds.where((breed) {
            return breed.name.toLowerCase().contains(lowerCaseQuery);
          }).toList();
    }
    emit(BreedLoaded(breeds: _filteredBreeds));
  }
}
