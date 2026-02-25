import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/features/game/data/datasource/game_datasource.dart';
import 'package:tictactoe/features/game/data/game_repository_impl.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/use_case/listen_to_game.dart';

import '../../data/fake/fake_local_datasource_service.dart';
import '../../data/mocked_games_dto.dart';

void main() {
  group('ListenToGame', () {
    test('given there is a game with the given id when called then returns the game', () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(savedGames: savedGameWithOngoing);
      final GameDatasource gameDatasource = GameDatasource(localDatabaseService: datasource);
      final GameRepositoryImpl repository = GameRepositoryImpl(datasource: gameDatasource);
      final Game expectedGame = Game.fromDto(savedGameWithOngoing[1]);

      expect(
        ListenToGame(repository: repository).call(id: expectedGame.id),
        emitsInOrder([isA<Game>().having((game) => game.id, 'id', expectedGame.id)]),
      );

      await gameDatasource.loadSavedGames();
    });

    test('given there is no game with the given id when called then returns null', () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(savedGames: []);
      final GameDatasource gameDatasource = GameDatasource(localDatabaseService: datasource);
      final GameRepositoryImpl repository = GameRepositoryImpl(datasource: gameDatasource);

      expect(
        ListenToGame(repository: repository).call(id: 'nonExistingId'),
        emitsInOrder([null]),
      );

      await gameDatasource.loadSavedGames();
    });
  });
}
