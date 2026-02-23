import 'package:tictactoe/src/game/domain/entity/game.dart';

abstract class GameStateRepository {
  Future<List<Game>> loadSavedGames(String ownerId);
  Future<void> updateCurrentGameState(Game currentGameState, String ownerId);
  Future<Game> getCurrentGameState(String ownerId);
}
