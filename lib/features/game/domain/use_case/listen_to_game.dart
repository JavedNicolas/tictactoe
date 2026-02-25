import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/repository/game_repository.dart';
import 'package:tictactoe/shared/extensions/list_extension.dart';

class ListenToGame {
  const ListenToGame({required this.repository});

  final GameRepository repository;

  Stream<Game?> call({required String id}) {
    return repository.listenToGames().map((games) => games.firstWhereOrNull((game) => game.id == id));
  }

  // TODO: dispose
  void dispose() {
    repository.dispose();
  }
}
