import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/src/game/data/game_repository_impl.dart';
import 'package:tictactoe/src/game/domain/entity/cell_state.dart';
import 'package:tictactoe/src/game/domain/entity/game.dart';
import 'package:tictactoe/src/game/domain/entity/game_status.dart';

import 'fake/fake_local_datasource.dart';
import 'mocked_games_dto.dart';

void main() {
  test('given there is saved games when loadSavedGames is called then we get those games', () async {
    final FakeLocalDatasource datasource = FakeLocalDatasource(
      savedGames: savedGameWithOngoing,
    );
    final GameStateRepositoryImpl repository = GameStateRepositoryImpl(datasource: datasource);

    final List<Game> games = await repository.loadSavedGames();

    expect(games.length, 2);
    expect(games.first.id, 'game-1');
    expect(games.first.status, GameStatus.player1Win);
    expect(games.last.id, 'game-2');
    expect(games.last.status, GameStatus.ongoing);
  });

  test('given there is an ongoing game when getCurrentGameState is called then it returns the ongoing game', () async {
    final FakeLocalDatasource datasource = FakeLocalDatasource(
      savedGames: savedGameWithOngoing,
    );
    final GameStateRepositoryImpl repository = GameStateRepositoryImpl(datasource: datasource);

    final Game? current = await repository.getCurrentGame();

    expect(current?.id, 'game-2');
    expect(current?.status, GameStatus.ongoing);
  });

  test('given only completed games when getCurrentGame is called then it returns null', () async {
    final FakeLocalDatasource datasource = FakeLocalDatasource(
      savedGames: saveGameOnlyCompleted,
    );
    final GameStateRepositoryImpl repository = GameStateRepositoryImpl(datasource: datasource);

    final Game? current = await repository.getCurrentGame();

    expect(current, isNull);
  });

  test('given there is a game ongoing when updateCurrentGame is called then datasource update the correct game',
      () async {
    final FakeLocalDatasource datasource = FakeLocalDatasource(
      savedGames: savedGameWithOngoing,
    );
    final GameStateRepositoryImpl repository = GameStateRepositoryImpl(datasource: datasource);

    final Game game = Game.fromDto(savedGameWithOngoing[1]).updateCell(index: 1, playerIndex: 0);
    await repository.updateCurrentGame(game: game);
    final Game? updated = await repository.getCurrentGame();

    expect(updated?.id, 'game-2');
    expect(updated?.status, GameStatus.ongoing);
    expect(updated?.cells[1].state, CellState.player1);
  });

  // TODO : use either
  test('given no saved games when getCurrentGameState is called then it throws', () async {
    final FakeLocalDatasource datasource = FakeLocalDatasource(savedGames: []);
    final GameStateRepositoryImpl repository = GameStateRepositoryImpl(datasource: datasource);

    await expectLater(repository.getCurrentGame(), throwsException);
  });
}
