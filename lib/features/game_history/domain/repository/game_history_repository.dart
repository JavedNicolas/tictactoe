import 'package:dartz/dartz.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/shared/errors/failure.dart';

abstract interface class GameHistoryRepository {
  Future<Either<Failure, List<Game>>> getGameHistory();
}
