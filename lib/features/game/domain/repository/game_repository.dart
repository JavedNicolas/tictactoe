import 'package:dartz/dartz.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/shared/errors/failure.dart';

abstract interface class GameRepository {
  Either<Failure, Stream<List<Game>>> listenToGames();
  Future<Either<Failure, List<Game>>> loadSavedGames();
  Future<Either<Failure, void>> updateGame({required Game game});
  Future<Either<Failure, Game?>> getOngoingGame();
  Future<Either<Failure, Game?>> getGame({required String gameId});
  void dispose();
}
