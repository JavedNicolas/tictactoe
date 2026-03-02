import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game_history/data/game_history_repository_impl.dart';
import 'package:tictactoe/features/game_history/domain/repository/game_history_repository.dart';
import 'package:tictactoe/features/game_history/domain/use_case/get_game_history.dart';
import 'package:tictactoe/features/game_history/presentation/provider/game_history_state.dart';

part 'game_history_notifier.g.dart';

@Riverpod()
class GameHistoryNotifier extends _$GameHistoryNotifier {
  late final GetGameHistory _getGameHistory;

  @override
  GameHistoryState build() {
    final GameHistoryRepository repository = ref.watch(gameHistoryRepositoryProvider);
    _getGameHistory = GetGameHistory(repository: repository);

    _getGameHistory.call().then(
          (games) => games.fold(
              (failure) => state = state.copyWith(status: GameHistoryStatus.error, errorMessage: failure.message),
              (games) => state = state.copyWith(status: GameHistoryStatus.loaded, games: games.reversed.toList())),
        );

    return GameHistoryState.initial();
  }
}
