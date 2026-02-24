import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/repository/game_repository.dart';

class HasOngoingGame {
  const HasOngoingGame();

  Future<bool> call({required GameRepository repository}) async {
    final Game? currentGame = await repository.getOngoingGame();
    return currentGame != null;
  }
}
