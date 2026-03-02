import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/features/game/data/datasource/game_datasource.dart';
import 'package:tictactoe/features/game/data/game_repository_impl.dart';
import 'package:tictactoe/features/game/domain/entity/cell_state.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/entity/game_status.dart';
import 'package:tictactoe/features/game/domain/use_case/start_new_game.dart';
import 'package:tictactoe/shared/errors/failure.dart';

import '../../data/fake/fake_local_datasource_service.dart';

void main() {
  group('StartNewGame', () {
    test('given a repository when StartNewGame is called then it saves a fresh ongoing game', () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(savedGames: []);
      final GameRepositoryImpl repository =
          GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      await StartNewGame(repository: repository).call();

      final Either<Failure, List<Game>> games = await repository.loadSavedGames();
      final Either<Failure, Game?> created = await repository.getOngoingGame();

      expect(games.isRight(), true);
      final List<Game> gamesList = games.getOrElse(() => []);
      expect(gamesList.length, 1);

      expect(created.isRight(), true);
      final Game? createdGame = created.getOrElse(() => null);
      expect(createdGame?.status, GameStatus.ongoing);
      expect(createdGame?.cells.every((cell) => cell.state == CellState.empty), isTrue);
    });
  });
}
