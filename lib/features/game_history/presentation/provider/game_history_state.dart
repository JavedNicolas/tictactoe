import 'package:tictactoe/features/game/domain/entity/game.dart';

enum GameHistoryStatus { loading, loaded, error }

class GameHistoryState {
  const GameHistoryState({required this.status, required this.games});

  factory GameHistoryState.initial() {
    return const GameHistoryState(status: GameHistoryStatus.loading, games: []);
  }

  final GameHistoryStatus status;
  final List<Game> games;

  bool get isLoading => status == GameHistoryStatus.loading;
  bool get isLoaded => status == GameHistoryStatus.loaded;
  bool get isError => status == GameHistoryStatus.error;

  GameHistoryState copyWith({GameHistoryStatus? status, List<Game>? games}) {
    return GameHistoryState(status: status ?? this.status, games: games ?? this.games);
  }
}
