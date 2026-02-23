import 'package:tictactoe/src/game/domain/entity/game_state.dart';

enum CurrentGameStatus { initial, inProgress, completed }

class CurrentGameState {
  const CurrentGameState({required this.gameState, this.status = CurrentGameStatus.initial});

  final GameState gameState;
  final CurrentGameStatus status;

  CurrentGameState copyWith({GameState? gameState, CurrentGameStatus? status}) {
    return CurrentGameState(gameState: gameState ?? this.gameState, status: status ?? this.status);
  }
}
