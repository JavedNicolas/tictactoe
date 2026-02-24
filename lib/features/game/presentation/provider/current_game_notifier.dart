import 'package:tictactoe/features/game/data/game_repository_impl.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/repository/game_repository.dart';
import 'package:tictactoe/features/game/domain/use_case/give_up_game.dart';
import 'package:tictactoe/features/game/domain/use_case/make_move.dart';
import 'package:tictactoe/features/game/domain/use_case/start_new_game.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_game_notifier.g.dart';

@riverpod
class CurrentGameNotifier extends _$CurrentGameNotifier {
  final StartNewGame _startNewGame = StartNewGame();
  final MakeMove _makeMove = MakeMove();
  final GiveUpGame _giveUpGame = GiveUpGame();

  @override
  Game build() {
    return Game.initial();
  }

  Future<void> startNewGame() async {
    final GameRepository repository = ref.read(gameRepositoryProvider);
    await _startNewGame.call(repository: repository);

    final Game newGame = (await repository.getCurrentGame()) ?? Game.initial();
    state = newGame;
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
