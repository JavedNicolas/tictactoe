import 'package:tictactoe/src/game/domain/entity/game.dart';
import 'package:tictactoe/src/game/domain/repository/game_repository.dart';

class StartNewGame {
  Future<void> call({required GameRepository repository}) async {
    await repository.updateCurrentGame(game: Game.initial());
  }
}
