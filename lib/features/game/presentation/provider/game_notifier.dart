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

@Riverpod(keepAlive: true)
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

    _getOnGoingGame.call().then((game) => _setGame(game: game));

    return GameState.initial();
  }

  void _setGame({required Game? game}) {
    final Game currentGame = game ?? Game.initial();
    state = state.copyWith(currentGame: currentGame, status: GameStatus.loaded);

    _currentGameSubscription = _listenToCurrentGame.call(id: currentGame.id).listen((game) {
      state = state.copyWith(currentGame: game);
    });
  }

  Future<void> startNewGame() async {
    state = state.copyWith(status: GameStatus.loading);
    await _currentGameSubscription?.cancel();

    await _startNewGame.call();

    _setGame(game: await _getOnGoingGame.call());
  }

  Future<void> makeMove({required int index, required int playerIndex}) async {
    await _makeMove.call(game: state.currentGame, index: index, playerIndex: playerIndex);
  }

  Future<void> giveUpGame() async {
    state = state.copyWith(status: GameStatus.loading);
    await _currentGameSubscription?.cancel();
    await _giveUpGame.call(game: state.currentGame);
  }
}
