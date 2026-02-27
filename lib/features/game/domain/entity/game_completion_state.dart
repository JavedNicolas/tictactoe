import 'package:tictactoe/features/game/domain/entity/game_status.dart';

class GameCompletionState {
  const GameCompletionState(this.status, {this.winningCombination});

  final GameStatus status;
  final List<int>? winningCombination;
}
