import 'package:dartz/dartz.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/repository/game_repository.dart';
import 'package:tictactoe/shared/errors/failure.dart';

class GiveUpGame {
  const GiveUpGame({required this.repository});

  final GameRepository repository;

  Future<Either<Failure, void>> call({required Game game}) async {
    final Game updatedGame = game.abandon();

    return await repository.updateGame(game: updatedGame);
  }
}
