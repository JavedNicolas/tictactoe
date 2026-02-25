import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/repository/game_repository.dart';

class GiveUpGame {
  const GiveUpGame({required this.repository});

  final GameRepository repository;

  Future<void> call({required Game game}) async {
    final Game updatedGame = game.abandon();

    await repository.updateGame(game: updatedGame);
  }
}
