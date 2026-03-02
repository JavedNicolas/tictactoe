import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/features/game/data/datasource/game_datasource.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game_history/data/game_history_repository_impl.dart';
import 'package:tictactoe/features/game_history/domain/repository/game_history_repository.dart';
import 'package:tictactoe/shared/errors/failure.dart';

import '../../game/data/fake/fake_local_datasource_service.dart';
import '../../game/data/mocked_games_dto.dart';

void main() {
  group('GameHistoryRepositoryImpl', () {
    test('given there is 3 saved games when getGameHistory is called then returns the 3 games', () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(
        savedGames: threeSavedGame,
      );
      final GameHistoryRepository repository =
          GameHistoryRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      final Either<Failure, List<Game>> games = await repository.getGameHistory();

      expect(games.isRight(), true);

      final List<Game> gamesList = games.getOrElse(() => []);
      expect(gamesList.length, 3);
      expect(gamesList[0].id, "game-1");
      expect(gamesList[1].id, "game-2");
      expect(gamesList[2].id, "game-3");
    });

    test('given there is no saved game when getGameHistory is called then returns an empty list', () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(savedGames: []);
      final GameHistoryRepository repository =
          GameHistoryRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      final Either<Failure, List<Game>> games = await repository.getGameHistory();

      expect(games.isRight(), true);

      final List<Game> gamesList = games.getOrElse(() => []);
      expect(gamesList.length, 0);
    });
  });
}
