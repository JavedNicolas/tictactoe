import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game_history/domain/repository/game_history_repository.dart';

class GetGameHistory {
  const GetGameHistory({required this.repository});

  final GameHistoryRepository repository;

  Future<List<Game>> call() async {
    return await repository.getGameHistory();
  }
}
