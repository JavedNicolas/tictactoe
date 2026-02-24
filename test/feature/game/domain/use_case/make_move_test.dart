import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/src/game/data/game_repository_impl.dart';
import 'package:tictactoe/src/game/domain/entity/cell_state.dart';
import 'package:tictactoe/src/game/domain/entity/game.dart';
import 'package:tictactoe/src/game/domain/entity/game_status.dart';
import 'package:tictactoe/src/game/domain/use_case/make_move.dart';

import '../../data/fake/fake_local_datasource.dart';
import '../../data/mocked_games_dto.dart';

void main() {
  group('MakeMove', () {
    test('given player1 turn when MakeMove is called then selected cell updates and game is saved', () async {
      final FakeLocalDatasource datasource = FakeLocalDatasource(savedGames: savedGameWithOngoing);
      final GameStateRepositoryImpl repository = GameStateRepositoryImpl(datasource: datasource);

      final Game currentGame = Game.fromDto(savedGameWithOngoing[1]);

      await MakeMove().call(index: 1, playerIndex: 0, repository: repository, game: currentGame);

      final Game? updated = await repository.getCurrentGame();
      expect(updated?.cells[1].state, CellState.player1);
      expect(updated?.status, GameStatus.ongoing);
    });

    test('given player1 move with ongoing game when MakeMove is called then AI follow-up move is triggered', () async {
      final FakeLocalDatasource datasource = FakeLocalDatasource(savedGames: savedGameWithOngoing);
      final GameStateRepositoryImpl repository = GameStateRepositoryImpl(datasource: datasource);

      final Game currentGame = Game.fromDto(savedGameWithOngoing[1]);

      await MakeMove().call(index: 0, playerIndex: 0, repository: repository, game: currentGame);

      final Game? updated = await repository.getCurrentGame();
      expect(updated?.cells[0].state, CellState.player1);
      expect(updated?.cells.where((cell) => cell.state == CellState.player1).length, 1);
      expect(updated?.cells.where((cell) => cell.state == CellState.player2).length, 1);
      expect(updated?.status, GameStatus.ongoing);
    });

    test('given a near-winning board for player1 when MakeMove completes line then status becomes player1Win',
        () async {
      final FakeLocalDatasource datasource = FakeLocalDatasource(savedGames: savedGameWithAGameAlmostWon);
      final GameStateRepositoryImpl repository = GameStateRepositoryImpl(datasource: datasource);

      final Game currentGame = Game.fromDto(savedGameWithAGameAlmostWon[0]);

      await MakeMove().call(index: 0, playerIndex: 0, repository: repository, game: currentGame);

      final Game? updated = await datasource
          .loadSavedGames()
          .then((dtos) => dtos.map((dto) => Game.fromDto(dto)).firstWhere((game) => game.id == currentGame.id));
      expect(updated?.cells[0].state, CellState.player1);
      expect(updated?.status, GameStatus.player1Win);
    });

    test('given a full board without winner when MakeMove fills last cell then status becomes draw', () async {
      final FakeLocalDatasource datasource = FakeLocalDatasource(savedGames: savedGameWithAGameAlmostDrawn);
      final GameStateRepositoryImpl repository = GameStateRepositoryImpl(datasource: datasource);

      final Game currentGame = Game.fromDto(savedGameWithAGameAlmostDrawn[0]);

      await MakeMove().call(index: 0, playerIndex: 0, repository: repository, game: currentGame);

      final Game? updated = await datasource
          .loadSavedGames()
          .then((dtos) => dtos.map((dto) => Game.fromDto(dto)).firstWhere((game) => game.id == currentGame.id));

      expect(updated?.cells[0].state, CellState.player1);
      expect(updated?.status, GameStatus.draw);
    });
  });
}
