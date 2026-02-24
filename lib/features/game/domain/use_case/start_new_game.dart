import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/repository/game_repository.dart';

class StartNewGame {
  const StartNewGame();

  Future<void> call({required GameRepository repository}) async {
    await repository.updateCurrentGame(game: Game.initial());
  }
}
