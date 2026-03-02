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
  group('Game Repository Impl', () {
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

    test('given there is an ongoing game when getOngoingGame is called then it returns the ongoing game', () async {
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

    test('given only completed games when getOngoingGame is called then it returns null', () async {
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

    test('given there is no saved game when getOngoingGame is called then it returns null', () async {
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

    test("given there is a game when addGame is called then it adds the game to the datasource", () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(
        savedGames: [],
      );
      final GameRepositoryImpl repository =
          GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      final Game game = Game.initial();
      await repository.addGame(game: game);
      final Either<Failure, List<Game>> games = await repository.loadSavedGames();

      expect(games.isRight(), true);

      final List<Game> gamesList = games.getOrElse(() => []);
      expect(gamesList.length, 1);
      expect(gamesList.any((g) => g.id == game.id), true);
      expect(gamesList.first.status, GameStatus.ongoing);
    });

    test(
        "given there is a game with the id game-1 in database when getGame is called with id game-1 then it returns the correct game",
        () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(
        savedGames: savedGameWithOngoing,
      );
      final GameRepositoryImpl repository =
          GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      final Either<Failure, Game?> game = await repository.getGame(gameId: 'game-1');

      expect(game.isRight(), true);

      final Game? currentGame = game.getOrElse(() => null);
      expect(currentGame?.id, 'game-1');
      expect(currentGame?.status, GameStatus.player1);
    });

    test(
        "given there is no game with the id 'game-3' in database when getGame is called with id game-3 then it returns null",
        () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(
        savedGames: savedGameWithOngoing,
      );
      final GameRepositoryImpl repository =
          GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      final Either<Failure, Game?> game = await repository.getGame(gameId: 'game-3');

      expect(game.isRight(), true);

      final Game? currentGame = game.getOrElse(() => null);
      expect(currentGame, isNull);
    });

    test('given there is a game ongoing when updateGame is called then datasource update the correct game', () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(
        savedGames: savedGameWithOngoing,
      );
      final GameRepositoryImpl repository =
          GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      final Game game = Game.fromDto(savedGameWithOngoing[1]).updateCell(index: 1, playerIndex: 0);
      await repository.updateGame(game: game);
      final Either<Failure, Game?> updated = await repository.getGame(gameId: 'game-2');

      expect(updated.isRight(), true);

      final Game? updatedGame = updated.getOrElse(() => null);
      expect(updatedGame?.id, 'game-2');
      expect(updatedGame?.status, GameStatus.ongoing);
      expect(updatedGame?.cells[1].state, CellState.player1);
    });

    test(
        'given there is no game with the id game id in database when updateGame is called with a game with id game-3 then it throws a DataNotFoundFailure',
        () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(
        savedGames: savedGameWithOngoing,
      );
      final GameRepositoryImpl repository =
          GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      final Game game = Game.initial();
      final Either<Failure, void> result = await repository.updateGame(game: game);

      expect(result.isLeft(), true);
      expect(result.swap().getOrElse(() => Failure(message: '')), isA<DataNotFoundFailure>());
    });
  });

  group('Game Repository Impl with disconnected datasource', () {
    test('given the datasource is disconnected when loadSavedGames is called then it returns a failure', () async {
      final FakeDisconnectedLocalDatasourceService datasource = FakeDisconnectedLocalDatasourceService();
      final GameRepositoryImpl repository =
          GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      final Either<Failure, List<Game>> games = await repository.loadSavedGames();

      expect(games.isLeft(), true);
      expect(games.swap().getOrElse(() => Failure(message: '')), isA<DatabaseQueryFailure>());
    });

    test('given the datasource is disconnected when getCurrentGameState is called then it returns a failure', () async {
      final FakeDisconnectedLocalDatasourceService datasource = FakeDisconnectedLocalDatasourceService();
      final GameRepositoryImpl repository =
          GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      final Either<Failure, Game?> current = await repository.getOngoingGame();

      expect(current.isLeft(), true);
      expect(current.swap().getOrElse(() => Failure(message: '')), isA<DatabaseQueryFailure>());
    });

    test('given the datasource is disconnected when addGame is called then it returns a failure', () async {
      final FakeDisconnectedLocalDatasourceService datasource = FakeDisconnectedLocalDatasourceService();
      final GameRepositoryImpl repository =
          GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      final Game game = Game.initial();
      final Either<Failure, void> result = await repository.addGame(game: game);

      expect(result.isLeft(), true);
      expect(result.swap().getOrElse(() => Failure(message: '')), isA<DatabaseQueryFailure>());
    });

    test('given the datasource is disconnected when updateGame is called then it returns a failure', () async {
      final FakeDisconnectedLocalDatasourceService datasource = FakeDisconnectedLocalDatasourceService();
      final GameRepositoryImpl repository =
          GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      final Game game = Game.initial();
      final Either<Failure, void> result = await repository.updateGame(game: game);

      expect(result.isLeft(), true);
      expect(result.swap().getOrElse(() => Failure(message: '')), isA<DatabaseQueryFailure>());
    });

    test('given the datasource is disconnected when getGame is called then it returns a failure', () async {
      final FakeDisconnectedLocalDatasourceService datasource = FakeDisconnectedLocalDatasourceService();
      final GameRepositoryImpl repository =
          GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      final Either<Failure, Game?> result = await repository.getGame(gameId: 'game-1');

      expect(result.isLeft(), true);
      expect(result.swap().getOrElse(() => Failure(message: '')), isA<DatabaseQueryFailure>());
    });
  });
}
