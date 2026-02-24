import 'package:tictactoe/features/game/data/game_repository_impl.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/repository/game_repository.dart';
import 'package:tictactoe/features/game/domain/use_case/give_up_game.dart';
import 'package:tictactoe/features/game/domain/use_case/make_move.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/domain/use_case/start_new_game.dart';

part 'game_notifier.g.dart';

@Riverpod(keepAlive: true)
class GameNotifier extends _$GameNotifier {
  final StartNewGame _startNewGame = const StartNewGame();
  final MakeMove _makeMove = const MakeMove();
  final GiveUpGame _giveUpGame = const GiveUpGame();

  @override
  Game build() {
    return Game.initial();
  }

  Future<void> startNewGame() async {
    final GameRepository repository = ref.read(gameRepositoryProvider);
    await _startNewGame.call(repository: repository);

    final Game? game = await repository.getOngoingGame();

    state = game!;
  }

  Future<void> makeMove({required int index, required int playerIndex}) async {
    final GameRepository repository = ref.read(gameRepositoryProvider);
    await _makeMove.call(game: state, index: index, playerIndex: playerIndex, repository: repository);

    final Game? updatedGame = await repository.getGame(gameId: state.id);

    state = updatedGame!;
  }

  Future<void> giveUpGame() async {
    final GameRepository repository = ref.read(gameRepositoryProvider);
    await _giveUpGame.call(game: state, gameRepository: repository);

    state = Game.initial();
  }
}
