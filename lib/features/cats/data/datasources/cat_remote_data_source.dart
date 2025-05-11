import 'package:dio/dio.dart';
import 'dart:developer';

import '../models/breed_model.dart';
import '../../../../core/network/dio_client.dart';

abstract class CatRemoteDataSource {
  /// Calls the https://api.thecatapi.com/v1/breeds API and returns a [List<BreedModel>].
  /// Throws a [ServerException] for all error codes.
  Future<List<BreedModel>> getAllBreeds();
  Future<List<BreedModel>> getCatsByBreed(String breedId);
}

class CatRemoteDataSourceImpl implements CatRemoteDataSource {
  final DioClient client;

  CatRemoteDataSourceImpl({required this.client});

  @override
  Future<List<BreedModel>> getAllBreeds() async {
    try {
      final response = await client.get('/breeds/');
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((json) => BreedModel.fromJson(json)).toList();
      } else {
        log('Error: ${response.statusCode} - ${response.statusMessage}');
        throw Exception('Failed to load breeds');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        log(
          'DioError: ${e.response?.statusCode} - ${e.response?.statusMessage}',
        );
      } else {
        log('DioError: ${e.message}');
      }
      throw Exception('Failed to load breeds');
    } catch (e) {
      log('Error fetching breeds: $e');
      throw Exception('Failed to load breeds');
    }
  }

  @override
  Future<List<BreedModel>> getCatsByBreed(String breedId) async {
    final response = await client.get(
      '/images/search',
      queryParameters: {'breed_ids': breedId, 'limit': 10},
    );
    if (response.statusCode == 200) {
      final List data = response.data;
      return data.map((json) => BreedModel.fromJson(json)).toList();
    } else {
      log('Error: ${response.statusCode} - ${response.statusMessage}');
      throw Exception('Failed to search breeds');
    }
  }
}
