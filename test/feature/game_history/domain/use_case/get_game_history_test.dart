import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/features/game/data/datasource/game_datasource.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game_history/data/game_history_repository_impl.dart';
import 'package:tictactoe/features/game_history/domain/repository/game_history_repository.dart';
import 'package:tictactoe/features/game_history/domain/use_case/get_game_history.dart';

import '../../../game/data/fake/fake_local_datasource_service.dart';
import '../../../game/data/mocked_games_dto.dart';

void main() {
  group('GiveUpGame', () {
    test('given there is 3 saved games when GetGameHistory is called then returns the 3 games', () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(
        savedGames: threeSavedGame,
      );
      final GameHistoryRepository repository =
          GameHistoryRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      final List<Game> games = await GetGameHistory(repository: repository).call();

      expect(games.length, 3);
      expect(games[0].id, "game-1");
      expect(games[1].id, "game-2");
      expect(games[2].id, "game-3");
    });

    test('given there is no saved game when GetGameHistory is called then returns an empty list', () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(savedGames: []);
      final GameHistoryRepository repository =
          GameHistoryRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      final List<Game> games = await GetGameHistory(repository: repository).call();

      expect(games.length, 0);
    });
  });
}
