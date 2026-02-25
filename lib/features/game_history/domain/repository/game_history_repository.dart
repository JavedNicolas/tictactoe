import 'package:tictactoe/features/game/domain/entity/game.dart';

abstract interface class GameHistoryRepository {
  Future<List<Game>> getGameHistory();
}
