import 'package:dartz/dartz.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/repository/game_repository.dart';
import 'package:tictactoe/shared/errors/failure.dart';

class GetOnGoingGame {
  const GetOnGoingGame({required this.repository});

  final GameRepository repository;

  Future<Either<Failure, Game?>> call() async {
    return await repository.getOngoingGame();
  }
}
