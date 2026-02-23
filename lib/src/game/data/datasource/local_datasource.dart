import 'package:tictactoe/src/game/data/dto/game_state_dto.dart';

abstract class LocalDatasource {
  Future<List<GameStateDto>> loadSavedGames({required String ownerId});
  Future<void> updateGameState({required GameStateDto gameState, required String ownerId});
}
