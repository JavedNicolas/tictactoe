import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/data/game_repository_impl.dart';
import 'package:tictactoe/features/game/domain/repository/game_repository.dart';
import 'package:tictactoe/features/home/domain/use_case/has_ongoing_game.dart';
import 'package:tictactoe/features/home/presentation/provider/home_state.dart';

part 'home_page_notifier.g.dart';

@Riverpod(keepAlive: true)
class HomePageNotifier extends _$HomePageNotifier {
  late final HasOngoingGame _hasOngoingGame;

  @override
  HomeState build() {
    final GameRepository repository = ref.read(gameRepositoryProvider);
    _hasOngoingGame = HasOngoingGame(repository: repository);

    _hasOngoingGame.call().fold(
          (failure) => state = state.copyWith(status: HomeStatus.error, errorMessage: failure.message),
          (hasOngoingGameStream) => hasOngoingGameStream.listen((hasOngoingGame) {
            state = state.copyWith(
              hasOngoingGame: hasOngoingGame,
              status: HomeStatus.loaded,
            );
          }),
        );

    return HomeState.initial();
  }
}
