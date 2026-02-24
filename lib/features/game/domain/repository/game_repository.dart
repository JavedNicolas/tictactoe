import 'package:tictactoe/features/game/domain/entity/game.dart';

abstract class GameRepository {
  Future<List<Game>> loadSavedGames();
  Future<void> updateCurrentGame({required Game game});
  Future<Game?> getCurrentGame();
  Future<Game?> getGame({required String gameId});
}
