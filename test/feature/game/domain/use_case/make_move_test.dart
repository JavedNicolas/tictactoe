import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/features/game/data/datasource/game_datasource.dart';
import 'package:tictactoe/features/game/data/game_repository_impl.dart';
import 'package:tictactoe/features/game/domain/entity/cell_state.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/entity/game_status.dart';
import 'package:tictactoe/features/game/domain/use_case/make_move.dart';
import 'package:tictactoe/shared/errors/failure.dart';

import '../../data/fake/fake_local_datasource_service.dart';
import '../../data/mocked_games_dto.dart';

void main() {
  group('MakeMove', () {
    test('given player1 turn when MakeMove is called then selected cell updates and game is saved', () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(savedGames: savedGameWithOngoing);
      final GameRepositoryImpl repository =
          GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      final Game currentGame = savedGameWithOngoing[1].toGame();

      await MakeMove(repository: repository).call(index: 1, playerIndex: 0, game: currentGame);

      final Either<Failure, Game?> updated = await repository.getOngoingGame();
      expect(updated.isRight(), true);

      final Game? updatedGame = updated.getOrElse(() => null);
      expect(updatedGame?.cells[1].state, CellState.player1);
      expect(updatedGame?.status, GameStatus.ongoing);
    });

    test('given player1 move with ongoing game when MakeMove is called then AI follow-up move is triggered', () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(savedGames: savedGameWithOngoing);
      final GameRepositoryImpl repository =
          GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      final Game currentGame = savedGameWithOngoing[1].toGame();

      await MakeMove(repository: repository).call(index: 0, playerIndex: 0, game: currentGame);
      final Either<Failure, Game?> afterPlayerMove = await repository.getOngoingGame();

      expect(afterPlayerMove.isRight(), true);

      final Game? afterPlayerMoveGame = afterPlayerMove.getOrElse(() => null);
      expect(afterPlayerMoveGame?.cells[0].state, CellState.player1);

      await MakeMove(repository: repository).callAi(game: afterPlayerMoveGame!);
      final Either<Failure, Game?> afterAiMove = await repository.getOngoingGame();

      expect(afterAiMove.isRight(), true);

      final Game? afterAiMoveGame = afterAiMove.getOrElse(() => null);
      expect(afterAiMoveGame?.cells.where((cell) => cell.state == CellState.player1).length, 1);
      expect(afterAiMoveGame?.cells.where((cell) => cell.state == CellState.player2).length, 1);
      expect(afterAiMoveGame?.status, GameStatus.ongoing);
    });

    test('given a near-winning board for player1 when MakeMove completes line then status becomes player1Win',
        () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(savedGames: savedGameWithAGameAlmostWon);
      final GameRepositoryImpl repository =
          GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      final Game currentGame = savedGameWithAGameAlmostWon[0].toGame();

      await MakeMove(repository: repository).call(index: 0, playerIndex: 0, game: currentGame);

      final Either<Failure, Game?> updated = await repository.getGame(gameId: currentGame.id);
      expect(updated.isRight(), true);

      final Game? updatedGame = updated.getOrElse(() => null);
      expect(updatedGame?.cells[0].state, CellState.player1);
      expect(updatedGame?.status, GameStatus.player1);
    });

    test('given a full board without winner when MakeMove fills last cell then status becomes draw', () async {
      final FakeLocalDatasourceService datasource =
          FakeLocalDatasourceService(savedGames: savedGameWithAGameAlmostDrawn);
      final GameRepositoryImpl repository =
          GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      final Game currentGame = savedGameWithAGameAlmostDrawn[0].toGame();

      await MakeMove(repository: repository).call(index: 0, playerIndex: 0, game: currentGame);

      final Either<Failure, Game?> updated = await repository.getGame(gameId: currentGame.id);
      expect(updated.isRight(), true);

      final Game? updatedGame = updated.getOrElse(() => null);
      expect(updatedGame?.cells[0].state, CellState.player1);
      expect(updatedGame?.status, GameStatus.draw);
    });
  });
}
