import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/features/game/data/datasource/game_datasource.dart';
import 'package:tictactoe/features/game/data/game_repository_impl.dart';
import 'package:tictactoe/features/game/domain/entity/cell_state.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/entity/game_status.dart';
import 'package:tictactoe/shared/errors/failure.dart';

import 'fake/fake_local_datasource_service.dart';
import 'mocked_games_dto.dart';

void main() {
  test('given there is saved games when loadSavedGames is called then we get those games', () async {
    final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(
      savedGames: savedGameWithOngoing,
    );
    final GameRepositoryImpl repository =
        GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

    final Either<Failure, List<Game>> games = await repository.loadSavedGames();

    expect(games.isRight(), true);

    final List<Game> gamesList = games.getOrElse(() => []);
    expect(gamesList.length, 2);
    expect(gamesList.first.id, 'game-1');
    expect(gamesList.first.status, GameStatus.player1);
    expect(gamesList.last.id, 'game-2');
    expect(gamesList.last.status, GameStatus.ongoing);
  });

  test('given there is an ongoing game when getCurrentGameState is called then it returns the ongoing game', () async {
    final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(
      savedGames: savedGameWithOngoing,
    );
    final GameRepositoryImpl repository =
        GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

    final Either<Failure, Game?> current = await repository.getOngoingGame();

    expect(current.isRight(), true);

    final Game? currentGame = current.getOrElse(() => null);
    expect(currentGame?.id, 'game-2');
    expect(currentGame?.status, GameStatus.ongoing);
  });

  test('given only completed games when getCurrentGame is called then it returns null', () async {
    final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(
      savedGames: saveGameOnlyCompleted,
    );
    final GameRepositoryImpl repository =
        GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

    final Either<Failure, Game?> current = await repository.getOngoingGame();

    expect(current.isRight(), true);

    final Game? currentGame = current.getOrElse(() => null);
    expect(currentGame, isNull);
  });

  test('Give there is no saved game when getCurrentGame is called then it returns null', () async {
    final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(
      savedGames: [],
    );
    final GameRepositoryImpl repository =
        GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

    final Either<Failure, Game?> current = await repository.getOngoingGame();

    expect(current.isRight(), true);

    final Game? currentGame = current.getOrElse(() => null);
    expect(currentGame, isNull);
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
    final Either<Failure, Game?> updated = await repository.getOngoingGame();

    expect(updated.isRight(), true);

    final Game? updatedGame = updated.getOrElse(() => null);
    expect(updatedGame?.id, 'game-2');
    expect(updatedGame?.status, GameStatus.ongoing);
    expect(updatedGame?.cells[1].state, CellState.player1);
  });
}
