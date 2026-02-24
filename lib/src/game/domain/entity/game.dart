import 'package:tictactoe/shared/constant.dart';
import 'package:tictactoe/src/game/data/dto/game_dto.dart';
import 'package:tictactoe/src/game/domain/entity/cell.dart';
import 'package:tictactoe/src/game/domain/entity/cell_state.dart';
import 'package:tictactoe/src/game/domain/entity/game_status.dart';
import 'package:uuid/uuid.dart';

class Game {
  Game({required this.id, required this.date, required this.cells, required this.status});

  factory Game.fromDto(GameDto dto) {
    return Game(
      id: dto.id,
      date: DateTime.fromMillisecondsSinceEpoch(dto.date),
      cells: dto.cells.map((cellDto) => cellDto.toCell()).toList(),
      status: GameStatus.fromString(dto.status),
    );
  }

  factory Game.initial() {
    return Game(
      id: const Uuid().v4(),
      date: DateTime.now(),
      cells: List.generate(kTicTacToeSize * kTicTacToeSize, (index) => Cell(index: index, state: CellState.empty)),
      status: GameStatus.ongoing,
    );
  }

  final String id;
  final DateTime date;
  final List<Cell> cells;
  final GameStatus status;

  bool get isCompleted => !status.isOngoing;
  bool get isOngoing => status.isOngoing;

  Game updateCell({required int index, required int? playerIndex}) {
    final List<Cell> updatedCells = List<Cell>.from(cells);
    updatedCells[index] = updatedCells[index].updateStateFromPlayerIndex(playerIndex: playerIndex);

    return _copyWith(cells: updatedCells);
  }

  Game updateStatus(GameStatus newStatus) {
    return _copyWith(status: newStatus);
  }

  Game abandon() {
    return _copyWith(status: GameStatus.abandoned);
  }

  Game _copyWith({List<Cell>? cells, GameStatus? status}) {
    return Game(id: id, date: date, cells: cells ?? this.cells, status: status ?? this.status);
  }
}
