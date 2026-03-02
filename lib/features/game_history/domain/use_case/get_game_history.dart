import 'package:dartz/dartz.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game_history/domain/repository/game_history_repository.dart';
import 'package:tictactoe/shared/errors/failure.dart';

class GetGameHistory {
  const GetGameHistory({required this.repository});

  final GameHistoryRepository repository;

  Future<Either<Failure, List<Game>>> call() async {
    return await repository.getGameHistory();
  }
}
