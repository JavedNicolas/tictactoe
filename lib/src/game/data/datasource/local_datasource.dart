import 'package:tictactoe/src/game/data/dto/game_dto.dart';

abstract class LocalDatasource {
  Future<List<GameDto>> loadSavedGames();
  Future<void> updateGameState({required GameDto gameState});
}
