import 'package:tictactoe/src/game/domain/entity/game.dart';

enum CurrentGameStatus { initial, inProgress, completed }

class CurrentGameState {
  const CurrentGameState({required this.gameState, this.status = CurrentGameStatus.initial});

  final Game gameState;
  final CurrentGameStatus status;

  CurrentGameState copyWith({Game? gameState, CurrentGameStatus? status}) {
    return CurrentGameState(gameState: gameState ?? this.gameState, status: status ?? this.status);
  }
}
