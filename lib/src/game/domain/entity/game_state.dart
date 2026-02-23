import 'package:tictactoe/shared/constant.dart';
import 'package:tictactoe/src/game/data/dto/game_state_dto.dart';
import 'package:tictactoe/src/game/domain/entity/cell.dart';
import 'package:tictactoe/src/game/domain/entity/cell_state.dart';
import 'package:uuid/uuid.dart';

class GameState {
  GameState({required this.id, required this.date, required this.cells, required this.isCompleted});

  factory GameState.fromDto(GameStateDto dto) {
    return GameState(
      id: dto.id,
      date: DateTime.fromMillisecondsSinceEpoch(dto.date),
      cells: dto.cells.map((cellDto) => cellDto.toCell()).toList(),
      isCompleted: dto.isCompleted,
    );
  }

  factory GameState.initial() {
    return GameState(
      id: const Uuid().v4(),
      date: DateTime.now(),
      cells: List.generate(kTicTacToeSize * kTicTacToeSize, (index) => Cell(index: index, state: CellState.empty)),
      isCompleted: false,
    );
  }

  final String id;
  final DateTime date;
  final List<Cell> cells;
  final bool isCompleted;

  GameState copyWith({List<Cell>? cells, bool? isCompleted}) {
    return GameState(id: id, date: date, cells: cells ?? this.cells, isCompleted: isCompleted ?? this.isCompleted);
  }
}
