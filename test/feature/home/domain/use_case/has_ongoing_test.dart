import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/features/game/data/datasource/game_datasource.dart';
import 'package:tictactoe/features/game/data/game_repository_impl.dart';
import 'package:tictactoe/features/home/domain/use_case/has_ongoing_game.dart';

import '../../../game/data/fake/fake_local_datasource_service.dart';
import '../../../game/data/mocked_games_dto.dart';

void main() {
  group('HasOngoingGame', () {
    test('given multiple games with one ongoing when called then returns true', () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(savedGames: savedGameWithOngoing);
      final GameDatasource gameDatasource = GameDatasource(localDatabaseService: datasource);
      final GameRepositoryImpl repository = GameRepositoryImpl(datasource: gameDatasource);

      expect(HasOngoingGame(repository: repository).call(), emitsInOrder([true]));

      await gameDatasource.loadSavedGames();
    });

    test('given no games when called then returns false', () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(savedGames: []);
      final GameDatasource gameDatasource = GameDatasource(localDatabaseService: datasource);
      final GameRepositoryImpl repository = GameRepositoryImpl(datasource: gameDatasource);

      expect(HasOngoingGame(repository: repository).call(), emitsInOrder([false]));

      await gameDatasource.loadSavedGames();
    });

    test('given multiple completed games and no ongoing when called then returns false', () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(savedGames: saveGameOnlyCompleted);
      final GameDatasource gameDatasource = GameDatasource(localDatabaseService: datasource);
      final GameRepositoryImpl repository = GameRepositoryImpl(datasource: gameDatasource);

      expect(HasOngoingGame(repository: repository).call(), emitsInOrder([false]));

      await gameDatasource.loadSavedGames();
    });
  });
}
