import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/features/game/data/datasource/game_datasource.dart';
import 'package:tictactoe/features/game/data/game_repository_impl.dart';
import 'package:tictactoe/features/game/domain/entity/cell_state.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/entity/game_status.dart';

import 'fake/fake_local_datasource_service.dart';
import 'mocked_games_dto.dart';

void main() {
  test('given there is saved games when loadSavedGames is called then we get those games', () async {
    final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(
      savedGames: savedGameWithOngoing,
    );
    final GameRepositoryImpl repository =
        GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

    final List<Game> games = await repository.loadSavedGames();

    expect(games.length, 2);
    expect(games.first.id, 'game-1');
    expect(games.first.status, GameStatus.player1);
    expect(games.last.id, 'game-2');
    expect(games.last.status, GameStatus.ongoing);
  });

  test('given there is an ongoing game when getCurrentGameState is called then it returns the ongoing game', () async {
    final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(
      savedGames: savedGameWithOngoing,
    );
    final GameRepositoryImpl repository =
        GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

    final Game? current = await repository.getOngoingGame();

    expect(current?.id, 'game-2');
    expect(current?.status, GameStatus.ongoing);
  });

  test('given only completed games when getCurrentGame is called then it returns null', () async {
    final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(
      savedGames: saveGameOnlyCompleted,
    );
    final GameRepositoryImpl repository =
        GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

    final Game? current = await repository.getOngoingGame();

    expect(current, isNull);
  });

  test('Give there is no saved game when getCurrentGame is called then it returns null', () async {
    final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(
      savedGames: [],
    );
    final GameRepositoryImpl repository =
        GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

    final Game? current = await repository.getOngoingGame();

    expect(current, isNull);
  });

  test('given there is a game ongoing when updateCurrentGame is called then datasource update the correct game',
      () async {
    final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(
      savedGames: savedGameWithOngoing,
    );
    final GameRepositoryImpl repository =
        GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

    final Game game = Game.fromDto(savedGameWithOngoing[1]).updateCell(index: 1, playerIndex: 0);
    await repository.updateGame(game: game);
    final Game? updated = await repository.getOngoingGame();

    expect(updated?.id, 'game-2');
    expect(updated?.status, GameStatus.ongoing);
    expect(updated?.cells[1].state, CellState.player1);
  });
}
