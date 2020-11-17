import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:myapp/core/error/exception.dart';

import 'package:myapp/core/error/failures.dart';
import 'package:myapp/core/network/network_info.dart';
import 'package:myapp/features/joke/data/datasources/joke_local_data_source.dart';
import 'package:myapp/features/joke/data/datasources/joke_remote_data_source.dart';
import 'package:myapp/features/joke/domain/entities/joke.dart';
import 'package:myapp/features/joke/domain/repositories/joke_repository.dart';

class JokeRepositoryImpl implements JokeRepository {
  final JokeRemoteDataSource remoteDataSource;
  final JokeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  JokeRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Joke>> getRandomJoke() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteJoke = await remoteDataSource.getRandomJoke();
        localDataSource.cacheJokeModel(remoteJoke);
        return Right(remoteJoke);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastJoke();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
