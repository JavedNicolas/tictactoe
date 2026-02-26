import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/shared/constant.dart';
import 'package:tictactoe/features/game/data/dto/cell_dto.dart';
import 'package:tictactoe/features/game/data/dto/game_dto.dart';
import 'package:tictactoe/features/game/domain/entity/cell_state.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/entity/game_status.dart';

void main() {
  group('Game', () {
    test('given no input when initial is called then an ongoing game with empty board is created', () {
      final Game game = Game.initial();

      expect(game.id, isNotEmpty);
      expect(game.status, GameStatus.ongoing);
      expect(game.cells.length, kTicTacToeSize * kTicTacToeSize);
      expect(game.cells.every((cell) => cell.state == CellState.empty), isTrue);
    });

    test('given a dto when fromDto is called then fields are mapped to the domain object', () {
      const GameDto dto = GameDto(
        id: 'dto-id',
        date: 1700000000000,
        cells: <CellDto>[
          CellDto(index: 0, state: 'player1'),
          CellDto(index: 1, state: 'empty'),
          CellDto(index: 2, state: 'player2'),
        ],
        status: 'draw',
      );

      final Game game = Game.fromDto(dto);

      expect(game.id, 'dto-id');
      expect(game.date, DateTime.fromMillisecondsSinceEpoch(1700000000000));
      expect(game.status, GameStatus.draw);
      expect(game.cells.length, 3);
      expect(game.cells[0].state, CellState.player1);
      expect(game.cells[1].state, CellState.empty);
      expect(game.cells[2].state, CellState.player2);
    });
  });

  test(
      "given a new game when updateCell is called then the specified cell is updated and a new game instance is returned",
      () {
    final Game game = Game.initial();

    final Game updatedGame = game.updateCell(index: 0, playerIndex: 0);

    expect(updatedGame.cells[0].state, CellState.player1);
    expect(game.cells[0].state, CellState.empty); // Original game should remain unchanged
    expect(identical(game, updatedGame), isFalse); // A new instance should be returned
  });

  test("given a game when abandon is called then a new game instance with abandoned status is returned", () {
    final Game game = Game.initial();

    final Game abandonedGame = game.abandon();

    expect(abandonedGame.status, GameStatus.abandoned);
    expect(game.status, GameStatus.ongoing); // Original game should remain unchanged
    expect(identical(game, abandonedGame), isFalse); // A new instance should be returned
  });

  test("given a game when setCompleted is called then a new game instance with updated status is returned", () {
    final Game game = Game.initial();

    final Game updatedStatusGame = game.setCompleted(GameStatus.draw);

    expect(updatedStatusGame.status, GameStatus.draw);
    expect(game.status, GameStatus.ongoing); // Original game should remain unchanged
    expect(identical(game, updatedStatusGame), isFalse); // A new instance should be returned
  });

  test("given a game won by player 1 when setCompleted is called with player1Win then isCompleted should return true",
      () {
    final Game game = Game.initial().setCompleted(GameStatus.player1Win, winningCombination: [0, 1, 2]);

    expect(game.isCompleted, isTrue);
    expect(game.isOngoing, isFalse);
    expect(game.winningCombination, [0, 1, 2]);
  });
}
