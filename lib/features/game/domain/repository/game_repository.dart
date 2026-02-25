import 'package:tictactoe/features/game/domain/entity/game.dart';

abstract interface class GameRepository {
  Stream<List<Game>> listenToGames();
  Future<List<Game>> loadSavedGames();
  Future<void> updateGame({required Game game});
  Future<Game?> getOngoingGame();
  Future<Game?> getGame({required String gameId});
  void dispose();
}
