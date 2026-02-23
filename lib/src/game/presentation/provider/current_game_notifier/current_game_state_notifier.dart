import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/src/game/domain/entity/game_state.dart';
import 'package:tictactoe/src/game/domain/repository/game_state_repository.dart';
import 'package:tictactoe/src/game/domain/use_case/make_move.dart';
import 'package:tictactoe/src/game/domain/use_case/start_new_game.dart';
import 'package:tictactoe/src/game/presentation/provider/current_game_notifier/current_game_state.dart';
import 'package:tictactoe/src/game/presentation/provider/provider_declaration.dart';

final currentGameStateNotifierProvider = NotifierProvider<CurrentGameStateNotifier, CurrentGameState>(() {
  return CurrentGameStateNotifier();
});

class CurrentGameStateNotifier extends Notifier<CurrentGameState> {
  final StartNewGame _startNewGame = StartNewGame();
  final MakeMove _makeMove = MakeMove();

  @override
  CurrentGameState build() {
    return CurrentGameState(gameState: GameState.initial());
  }

  Future<void> startNewGame(String ownerId) async {
    final GameStateRepository repository = ref.read(gameStateRepositoryProvider);
    await _startNewGame.call(ownerId: ownerId, repository: repository);

    final GameState newGameState = await repository.getCurrentGameState(ownerId);
    state = state.copyWith(gameState: newGameState, status: CurrentGameStatus.inProgress);
  }

  Future<void> makeMove({required int index, required String symbol, required String ownerId}) async {
    final GameStateRepository repository = ref.read(gameStateRepositoryProvider);
    await _makeMove.call(
      gameState: state.gameState,
      index: index,
      symbol: symbol,
      ownerId: ownerId,
      repository: repository,
    );

    final GameState updatedGameState = await repository.getCurrentGameState(ownerId);
    state = state.copyWith(
      gameState: updatedGameState,
      status: updatedGameState.isCompleted ? CurrentGameStatus.completed : CurrentGameStatus.inProgress,
    );
  }
}
