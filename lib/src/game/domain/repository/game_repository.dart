import 'package:tictactoe/src/game/domain/entity/game.dart';

abstract class GameRepository {
  Future<List<Game>> loadSavedGames();
  Future<void> updateCurrentGameState({required Game game});
  Future<Game> getCurrentGameState();
}
