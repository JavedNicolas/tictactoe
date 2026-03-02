import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/features/game/domain/entity/cell.dart';
import 'package:tictactoe/features/game/domain/entity/cell_state.dart';

void main() {
  group('Cell', () {
    test('given an empty cell when reading isEmpty flag then returns true', () {
      const Cell emptyCell = Cell(index: 0, state: CellState.empty);

      expect(emptyCell.isEmpty, isTrue);
      expect(emptyCell.isNotEmpty, isFalse);
    });

    test('given a filled cell when reading isEmpty flag then returns false', () {
      const Cell filledCell = Cell(index: 1, state: CellState.player1);

      expect(filledCell.isEmpty, isFalse);
      expect(filledCell.isNotEmpty, isTrue);
    });

    test('given an empty cell when updateStateFromPlayerIndex is called then state updates and index is preserved', () {
      const Cell cell = Cell(index: 3, state: CellState.empty);

      final Cell updated = cell.updateStateFromPlayerIndex(playerIndex: 0);

      expect(updated.index, cell.index);
      expect(updated.state, CellState.player1);
      expect(cell.state, CellState.empty);
    });

    test(
        'given a cell when updateStateFromPlayerIndex is called with new player index then only provided values are updated',
        () {
      const Cell cell = Cell(index: 6, state: CellState.player1);

      final Cell copied = cell.updateStateFromPlayerIndex(playerIndex: 1);

      expect(copied.index, 6);
      expect(copied.state, CellState.player2);
    });
  });
}
