import 'package:tictactoe/shared/extensions/list_extension.dart';

enum CellState {
  empty,
  player1,
  player2;

  factory CellState.fromString(String? value) {
    return CellState.values.firstWhereOrNull((state) => state.name == value) ?? CellState.empty;
  }

  factory CellState.fromPlayerIndex(int? playerIndex) {
    if (playerIndex == null || playerIndex >= 2 || playerIndex < 0) {
      return CellState.empty;
    }

    return playerIndex == 0 ? CellState.player1 : CellState.player2;
  }

  bool compare(CellState other) {
    return name == other.name;
  }
}
