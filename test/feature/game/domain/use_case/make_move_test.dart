import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/features/game/data/datasource/game_datasource.dart';
import 'package:tictactoe/features/game/data/game_repository_impl.dart';
import 'package:tictactoe/features/game/domain/entity/cell_state.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/entity/game_status.dart';
import 'package:tictactoe/features/game/domain/use_case/make_move.dart';

import '../../data/fake/fake_local_datasource_service.dart';
import '../../data/mocked_games_dto.dart';

void main() {
  group('MakeMove', () {
    test('given player1 turn when MakeMove is called then selected cell updates and game is saved', () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(savedGames: savedGameWithOngoing);
      final GameRepositoryImpl repository =
          GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      final Game currentGame = Game.fromDto(savedGameWithOngoing[1]);

      await MakeMove(repository: repository).call(index: 1, playerIndex: 0, game: currentGame);

      final Game? updated = await repository.getOngoingGame();
      expect(updated?.cells[1].state, CellState.player1);
      expect(updated?.status, GameStatus.ongoing);
    });

    test('given player1 move with ongoing game when MakeMove is called then AI follow-up move is triggered', () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(savedGames: savedGameWithOngoing);
      final GameRepositoryImpl repository =
          GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      final Game currentGame = Game.fromDto(savedGameWithOngoing[1]);

      await MakeMove(repository: repository).call(index: 0, playerIndex: 0, game: currentGame);

      final Game? updated = await repository.getOngoingGame();
      expect(updated?.cells[0].state, CellState.player1);
      expect(updated?.cells.where((cell) => cell.state == CellState.player1).length, 1);
      expect(updated?.cells.where((cell) => cell.state == CellState.player2).length, 1);
      expect(updated?.status, GameStatus.ongoing);
    });

    test('given a near-winning board for player1 when MakeMove completes line then status becomes player1Win',
        () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(savedGames: savedGameWithAGameAlmostWon);
      final GameRepositoryImpl repository =
          GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      final Game currentGame = Game.fromDto(savedGameWithAGameAlmostWon[0]);

      await MakeMove(repository: repository).call(index: 0, playerIndex: 0, game: currentGame);

      final Game? updated = await repository.getGame(gameId: currentGame.id);
      expect(updated?.cells[0].state, CellState.player1);
      expect(updated?.status, GameStatus.player1Win);
    });

    test('given a full board without winner when MakeMove fills last cell then status becomes draw', () async {
      final FakeLocalDatasourceService datasource =
          FakeLocalDatasourceService(savedGames: savedGameWithAGameAlmostDrawn);
      final GameRepositoryImpl repository =
          GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      final Game currentGame = Game.fromDto(savedGameWithAGameAlmostDrawn[0]);

      await MakeMove(repository: repository).call(index: 0, playerIndex: 0, game: currentGame);

      final Game? updated = await repository.getGame(gameId: currentGame.id);

      expect(updated?.cells[0].state, CellState.player1);
      expect(updated?.status, GameStatus.draw);
    });
  });
}
