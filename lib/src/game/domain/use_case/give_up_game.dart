import 'package:tictactoe/src/game/domain/entity/game.dart';
import 'package:tictactoe/src/game/domain/entity/game_status.dart';
import 'package:tictactoe/src/game/domain/repository/game_repository.dart';

class GiveUpGame {
  Future<void> call({required Game game, required GameRepository gameRepository}) async {
    final Game updatedGame = game.copyWith(status: GameStatus.abandoned);

    await gameRepository.updateCurrentGameState(game: updatedGame);
  }
}
