import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game_history/data/game_history_repository_impl.dart';
import 'package:tictactoe/features/game_history/domain/repository/game_history_repository.dart';
import 'package:tictactoe/features/game_history/domain/user_case/get_game_history.dart';
import 'package:tictactoe/features/game_history/presentation/provider/game_history_state.dart';

part 'game_history_notifier.g.dart';

@Riverpod(keepAlive: true)
class GameHistoryNotifier extends _$GameHistoryNotifier {
  late final GetGameHistory _getGameHistory;
  @override
  GameHistoryState build() {
    final GameHistoryRepository repository = ref.watch(gameHistoryRepositoryProvider);
    _getGameHistory = GetGameHistory(repository: repository);

    return GameHistoryState.initial();
  }

  Future<void> loadGameHistory() async {
    state = state.copyWith(status: GameHistoryStatus.loading);

    final List<Game> games = await _getGameHistory();
    state = state.copyWith(status: GameHistoryStatus.loaded, games: games);
  }
}
