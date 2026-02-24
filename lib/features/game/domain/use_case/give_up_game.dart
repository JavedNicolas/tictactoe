import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/repository/game_repository.dart';

class GiveUpGame {
  Future<void> call({required Game game, required GameRepository gameRepository}) async {
    final Game updatedGame = game.abandon();

    await gameRepository.updateCurrentGame(game: updatedGame);
  }
}
