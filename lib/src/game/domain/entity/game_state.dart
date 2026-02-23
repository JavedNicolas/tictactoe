import 'package:tictactoe/shared/constant.dart';
import 'package:tictactoe/src/game/data/dto/game_state_dto.dart';
import 'package:tictactoe/src/game/domain/entity/cell.dart';
import 'package:tictactoe/src/game/domain/entity/cell_state.dart';
import 'package:tictactoe/src/game/domain/entity/game_state_status.dart';
import 'package:uuid/uuid.dart';

class GameState {
  GameState({required this.id, required this.date, required this.cells, required this.status});

  factory GameState.fromDto(GameStateDto dto) {
    return GameState(
      id: dto.id,
      date: DateTime.fromMillisecondsSinceEpoch(dto.date),
      cells: dto.cells.map((cellDto) => cellDto.toCell()).toList(),
      status: GameStateStatus.fromString(dto.status),
    );
  }

  factory GameState.initial() {
    return GameState(
      id: const Uuid().v4(),
      date: DateTime.now(),
      cells: List.generate(kTicTacToeSize * kTicTacToeSize, (index) => Cell(index: index, state: CellState.empty)),
      status: GameStateStatus.ongoing,
    );
  }

  final String id;
  final DateTime date;
  final List<Cell> cells;
  final GameStateStatus status;

  bool get isCompleted => status.isPlayer1Win || status.isPlayer2Win || status.isDraw;

  GameState copyWith({List<Cell>? cells, GameStateStatus? status}) {
    return GameState(id: id, date: date, cells: cells ?? this.cells, status: status ?? this.status);
  }
}
