import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/core/network/network_info.dart';
import 'package:myapp/features/helloworld/presentation/bloc/helloworld_bloc.dart';
import 'package:myapp/features/joke/data/datasources/joke_local_data_source.dart';
import 'package:myapp/features/joke/data/datasources/joke_remote_data_source.dart';
import 'package:myapp/features/joke/data/repositories/joke_repository_impl.dart';
import 'package:myapp/features/joke/domain/repositories/joke_repository.dart';
import 'package:myapp/features/joke/domain/usecases/get_random_joke.dart';
import 'package:myapp/features/joke/presentation/bloc/joke_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Joke
  //Bloc
  sl.registerFactory(
    () => JokeBloc(
      randomJoke: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetRandomJoke(sl()));

  // Repository
  sl.registerLazySingleton<JokeRepository>(
    () => JokeRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<JokeRemoteDataSource>(
    () => JokeRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<JokeLocalDataSource>(
    () => JokeLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Features - HelloWorld
  //Bloc
  sl.registerFactory(
    () => HelloworldBloc(),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
