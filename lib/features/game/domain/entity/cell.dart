import 'package:tictactoe/features/game/domain/entity/cell_state.dart';

class Cell {
  const Cell({required this.index, required this.state});

  final int index;
  final CellState state;

  bool get isEmpty => state == CellState.empty;
  bool get isNotEmpty => !isEmpty;

  Cell updateStateFromPlayerIndex({required int? playerIndex}) {
    return _copyWith(state: CellState.fromPlayerIndex(playerIndex));
  }

  Cell _copyWith({CellState? state}) {
    return Cell(index: index, state: state ?? this.state);
  }
}
