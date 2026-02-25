import 'package:tictactoe/features/game/domain/repository/game_repository.dart';

class HasOngoingGame {
  const HasOngoingGame({required this.repository});

  final GameRepository repository;

  Stream<bool> call() {
    return repository.listenToGames().map((games) => games.any((game) => game.isOngoing));
  }
}
