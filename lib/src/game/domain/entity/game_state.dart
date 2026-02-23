import 'package:tictactoe/shared/constant.dart';
import 'package:tictactoe/src/game/data/dto/game_state_dto.dart';
import 'package:uuid/uuid.dart';

class GameState {
  GameState({required this.id, required this.date, required this.cells, required this.isCompleted});

  factory GameState.fromDto(GameStateDto dto) {
    return GameState(
      id: dto.id,
      date: DateTime.fromMillisecondsSinceEpoch(dto.date),
      cells: dto.cells,
      isCompleted: dto.isCompleted,
    );
  }

  factory GameState.initial() {
    return GameState(
      id: const Uuid().v4(),
      date: DateTime.now(),
      cells: List.filled(kTicTacToeSize * kTicTacToeSize, ''),
      isCompleted: false,
    );
  }

  final String id;
  final DateTime date;
  final List<String> cells;
  final bool isCompleted;

  GameState copyWith({List<String>? cells, bool? isCompleted}) {
    return GameState(id: id, date: date, cells: cells ?? this.cells, isCompleted: isCompleted ?? this.isCompleted);
  }
}
