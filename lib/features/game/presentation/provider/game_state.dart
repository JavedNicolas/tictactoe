import 'package:tictactoe/features/game/domain/entity/game.dart';

enum GameStatus { loading, loaded, error }

class GameState {
  const GameState({required this.status, required this.currentGame});

  factory GameState.initial() => GameState(status: GameStatus.loading, currentGame: Game.initial());

  final Game currentGame;
  final GameStatus status;

  bool get isLoading => status == GameStatus.loading;
  bool get isLoaded => status == GameStatus.loaded;
  bool get hasError => status == GameStatus.error;

  GameState copyWith({Game? currentGame, GameStatus? status}) {
    return GameState(
      currentGame: currentGame ?? this.currentGame,
      status: status ?? this.status,
    );
  }
}
