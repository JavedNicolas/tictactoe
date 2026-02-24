import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/src/game/domain/entity/cell_state.dart';

void main() {
  group('CellState', () {
    test('given valid state names when fromString is called then matching enum values are returned', () {
      expect(CellState.fromString('player1'), CellState.player1);
      expect(CellState.fromString('player2'), CellState.player2);
    });

    test('given null or invalid value when fromString is called then empty is returned', () {
      expect(CellState.fromString(null), CellState.empty);
      expect(CellState.fromString('unknown'), CellState.empty);
    });

    test('given player indexes when fromPlayerIndex is called then mapped states are returned', () {
      expect(CellState.fromPlayerIndex(null), CellState.empty);
      expect(CellState.fromPlayerIndex(0), CellState.player1);
      expect(CellState.fromPlayerIndex(1), CellState.player2);
      expect(CellState.fromPlayerIndex(8), CellState.empty);
    });

    test('given two states when compare is called then true is returned only for same state', () {
      expect(CellState.player1.compare(CellState.player1), isTrue);
      expect(CellState.player1.compare(CellState.player2), isFalse);
    });
  });
}
