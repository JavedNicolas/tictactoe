import 'package:tictactoe/src/game/domain/entity/game_state.dart';

abstract class GameStateRepository {
  Future<List<GameState>> loadSavedGames(String ownerId);
  Future<void> updateCurrentGameState(GameState currentGameState, String ownerId);
  Future<GameState> getCurrentGameState(String ownerId);
}
