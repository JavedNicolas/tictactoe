import 'dart:async';

import 'package:tictactoe/features/game/data/game_repository_impl.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/repository/game_repository.dart';
import 'package:tictactoe/features/game/domain/use_case/get_on_going_game.dart';
import 'package:tictactoe/features/game/domain/use_case/listen_to_game.dart';
import 'package:tictactoe/features/game/domain/use_case/give_up_game.dart';
import 'package:tictactoe/features/game/domain/use_case/make_move.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/domain/use_case/start_new_game.dart';
import 'package:tictactoe/features/game/presentation/provider/game_state.dart';

part 'game_notifier.g.dart';

@Riverpod()
class GameNotifier extends _$GameNotifier {
  late final GetOnGoingGame _getOnGoingGame;
  late final ListenToGame _listenToCurrentGame;
  late final StartNewGame _startNewGame;
  late final MakeMove _makeMove;
  late final GiveUpGame _giveUpGame;

  StreamSubscription<Game?>? _currentGameSubscription;

  @override
  GameState build() {
    final GameRepository repository = ref.watch(gameRepositoryProvider);
    _getOnGoingGame = GetOnGoingGame(repository: repository);
    _listenToCurrentGame = ListenToGame(repository: repository);
    _startNewGame = StartNewGame(repository: repository);
    _makeMove = MakeMove(repository: repository);
    _giveUpGame = GiveUpGame(repository: repository);

    // load the current game on initialization and listen to its changes
    _getOnGoingGame.call().then((game) {
      game.fold(
        (failure) => state = state.copyWith(status: GameStateStatus.error),
        (game) => _setGame(game: game),
      );
    });

    // close the stream subscription when the notifier is disposed
    ref.onDispose(() {
      _currentGameSubscription?.cancel();
    });

    return GameState.initial();
  }

  void _setGame({required Game? game}) {
    final Game currentGame = game ?? Game.initial();
    state =
        state.copyWith(currentGame: currentGame, status: GameStateStatus.loaded, currentPlayer: CurrentPlayer.player1);

    _listenToCurrentGame.call(id: currentGame.id).fold(
          (failure) => state = state.copyWith(status: GameStateStatus.error),
          (stream) => stream.listen((game) {
            state = state.copyWith(currentGame: game, currentPlayer: CurrentPlayer.player1);
          }),
        );
  }

  Future<void> startNewGame() async {
    state = state.copyWith(status: GameStateStatus.loading);
    await _currentGameSubscription?.cancel();

    await _startNewGame.call();
    await _getOnGoingGame.call().then((game) {
      game.fold(
        (failure) => state = state.copyWith(status: GameStateStatus.error),
        (game) => _setGame(game: game),
      );
    });
  }

  Future<void> makeMove({required int index, required int playerIndex}) async {
    await _makeMove.call(game: state.currentGame, index: index, playerIndex: playerIndex);
    state = state.copyWith(currentPlayer: CurrentPlayer.player2);

    if (state.isLoading || state.currentGame.isCompleted) {
      return;
    }

    if (state.isPlayer2Turn) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        makeAiMove();
      });
    }
  }

  Future<void> makeAiMove() async {
    await _makeMove.callAi(game: state.currentGame).then((either) {
      either.fold(
        (failure) => state = state.copyWith(status: GameStateStatus.error),
        (_) => state = state.copyWith(currentPlayer: CurrentPlayer.player1),
      );
    });
  }

  Future<void> giveUpGame() async {
    state = state.copyWith(status: GameStateStatus.loading);
    await _currentGameSubscription?.cancel();
    await _giveUpGame.call(game: state.currentGame).then((either) {
      either.fold(
        (failure) => state = state.copyWith(status: GameStateStatus.error),
        (_) => state = state.copyWith(currentGame: Game.initial(), status: GameStateStatus.loaded),
      );
    });
  }
}
