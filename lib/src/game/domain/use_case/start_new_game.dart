import 'package:tictactoe/src/game/domain/entity/game.dart';
import 'package:tictactoe/src/game/domain/repository/game_repository.dart';

class StartNewGame {
  Future<void> call({required GameStateRepository repository, required String ownerId}) async {
    await repository.updateCurrentGameState(Game.initial(), ownerId);
  }
}
