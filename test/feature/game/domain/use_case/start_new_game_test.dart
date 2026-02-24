import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/features/game/data/datasource/game_datasource.dart';
import 'package:tictactoe/features/game/data/game_repository_impl.dart';
import 'package:tictactoe/features/game/domain/entity/cell_state.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/entity/game_status.dart';
import 'package:tictactoe/features/game/domain/use_case/start_new_game.dart';

import '../../data/fake/fake_local_datasource_service.dart';

void main() {
  group('StartNewGame', () {
    test('given a repository when StartNewGame is called then it saves a fresh ongoing game', () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(savedGames: []);
      final GameStateRepositoryImpl repository =
          GameStateRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      await StartNewGame().call(repository: repository);

      final List<Game> games = await repository.loadSavedGames();
      final Game? created = await repository.getCurrentGame();

      expect(games.length, 1);
      expect(created?.status, GameStatus.ongoing);
      expect(created?.cells.every((cell) => cell.state == CellState.empty), isTrue);
    });
  });
}
