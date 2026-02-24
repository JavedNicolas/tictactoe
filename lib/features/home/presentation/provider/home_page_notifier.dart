import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/data/game_repository_impl.dart';
import 'package:tictactoe/features/game/domain/repository/game_repository.dart';
import 'package:tictactoe/features/home/domain/use_case/has_ongoing_game.dart';
import 'package:tictactoe/features/home/presentation/provider/home_state.dart';

part 'home_page_notifier.g.dart';

@Riverpod(keepAlive: true)
class HomePageNotifier extends _$HomePageNotifier {
  final HasOngoingGame _hasOngoingGame = const HasOngoingGame();

  @override
  HomeState build() {
    final GameRepository repository = ref.read(gameRepositoryProvider);
    _hasOngoingGame.call(repository: repository).then((hasOngoingGame) {
      state = HomeState(
        hasOngoingGame: hasOngoingGame,
        status: HomeStatus.loaded,
      );
    }).catchError((error) {
      state = HomeState(
        hasOngoingGame: false,
        status: HomeStatus.error,
      );
    });

    return HomeState(
      hasOngoingGame: false,
      status: HomeStatus.loading,
    );
  }
}
