import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/repository/game_repository.dart';

class GetOnGoingGame {
  const GetOnGoingGame({required this.repository});

  final GameRepository repository;

  Future<Game?> call() async {
    return await repository.getOngoingGame();
  }
}
