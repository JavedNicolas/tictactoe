import 'package:tictactoe/features/game/domain/entity/game.dart';

enum GameStateStatus { loading, loaded, error }

class GameState {
  const GameState({required this.status, required this.currentGame});

  factory GameState.initial() => GameState(status: GameStateStatus.loading, currentGame: Game.initial());

  final Game currentGame;
  final GameStateStatus status;

  bool get isLoading => status == GameStateStatus.loading;
  bool get isLoaded => status == GameStateStatus.loaded;
  bool get hasError => status == GameStateStatus.error;

  GameState copyWith({Game? currentGame, GameStateStatus? status}) {
    return GameState(
      currentGame: currentGame ?? this.currentGame,
      status: status ?? this.status,
    );
  }
}
