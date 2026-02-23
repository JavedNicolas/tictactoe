import 'package:tictactoe/src/game/domain/entity/game_state.dart';
import 'package:tictactoe/src/game/domain/repository/game_state_repository.dart';

class StartNewGame {
  Future<void> call({required GameStateRepository repository, required String ownerId}) async {
    await repository.updateCurrentGameState(GameState.initial(), ownerId);
  }
}
