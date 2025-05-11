import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/network/dio_client.dart';
import 'features/cats/data/datasources/cat_remote_data_source.dart';
import 'features/cats/data/repositories/cat_repository_impl.dart';
import 'features/cats/domain/repositories/cat_repository.dart';
import 'features/cats/domain/usecases/get_breeds_use_case.dart';
import 'features/cats/domain/usecases/get_by_breeds_use_case.dart';
import 'features/cats/presentation/cubit/breed_cubit.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async {
  final apiKey = dotenv.env['apiKey']!;
  final baseUrl = dotenv.env['baseUrl']!;

  // Register Dio
  getIt.registerLazySingleton(() => Dio());

  // Register DioClient
  getIt.registerLazySingleton(
    () => DioClient(baseUrl: baseUrl, apiKey: apiKey),
  );

  // Register Data Sources
  getIt.registerLazySingleton<CatRemoteDataSource>(
    () => CatRemoteDataSourceImpl(client: getIt<DioClient>()),
  );

  // Register Repositories
  getIt.registerLazySingleton<CatRepository>(
    () => CatRepositoryImpl(remoteDataSource: getIt<CatRemoteDataSource>()),
  );

  // Register Use Cases
  getIt.registerLazySingleton(
    () => GetBreedsUseCase(repository: getIt<CatRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetByBreedsUseCase(repository: getIt<CatRepository>()),
  );

  // Register Cubit
  getIt.registerFactory(() => BreedCubit(repository: getIt<CatRepository>()));
}
