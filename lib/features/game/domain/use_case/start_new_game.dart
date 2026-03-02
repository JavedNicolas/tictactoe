import 'package:dartz/dartz.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/repository/game_repository.dart';
import 'package:tictactoe/shared/errors/failure.dart';

class StartNewGame {
  const StartNewGame({required this.repository});

  final GameRepository repository;

  Future<Either<Failure, void>> call() async {
    return await repository.updateGame(game: Game.initial());
  }
}
