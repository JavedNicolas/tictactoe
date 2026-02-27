import 'package:tictactoe/features/game/domain/entity/game.dart';

enum GameStateStatus { loading, loaded, error }

enum CurrentPlayer { player1, player2, none }

class GameState {
  const GameState({required this.status, required this.currentGame, this.currentPlayer = CurrentPlayer.none});

  factory GameState.initial() => GameState(status: GameStateStatus.loading, currentGame: Game.initial());

  final Game currentGame;
  final GameStateStatus status;
  final CurrentPlayer currentPlayer;

  bool get isLoading => status == GameStateStatus.loading;
  bool get isLoaded => status == GameStateStatus.loaded;
  bool get hasError => status == GameStateStatus.error;

  bool get isPlayer1Turn => currentPlayer == CurrentPlayer.player1;
  bool get isPlayer2Turn => currentPlayer == CurrentPlayer.player2;
  bool get isNoOnesTurn => currentPlayer == CurrentPlayer.none;

  GameState copyWith({Game? currentGame, GameStateStatus? status, CurrentPlayer? currentPlayer}) {
    final Game newCurrentGame = currentGame ?? this.currentGame;
    final CurrentPlayer newCurrentPlayer =
        newCurrentGame.isCompleted ? CurrentPlayer.none : currentPlayer ?? this.currentPlayer;

    return GameState(
      currentGame: newCurrentGame,
      status: status ?? this.status,
      currentPlayer: newCurrentPlayer,
    );
  }
}
