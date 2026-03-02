import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/features/game/data/datasource/game_datasource.dart';
import 'package:tictactoe/features/game/data/game_repository_impl.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/use_case/listen_to_game.dart';
import 'package:tictactoe/shared/errors/failure.dart';

import '../../data/fake/fake_local_datasource_service.dart';
import '../../data/mocked_games_dto.dart';

void main() {
  group('ListenToGame', () {
    test('given there is a game with the given id when called then returns the game', () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(savedGames: savedGameWithOngoing);
      final GameDatasource gameDatasource = GameDatasource(localDatabaseService: datasource);
      final GameRepositoryImpl repository = GameRepositoryImpl(datasource: gameDatasource);
      final Game expectedGame = Game.fromDto(savedGameWithOngoing[1]);

      final Either<Failure, Stream<Game?>> result = ListenToGame(repository: repository).call(id: expectedGame.id);

      expect(result.isRight(), true);

      expect(
        result.getOrElse(() => const Stream.empty()),
        emitsInOrder([isA<Game>().having((game) => game.id, 'id', expectedGame.id)]),
      );

      await gameDatasource.loadSavedGames();
    });

    test('given there is no game with the given id when called then returns null', () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(savedGames: []);
      final GameDatasource gameDatasource = GameDatasource(localDatabaseService: datasource);
      final GameRepositoryImpl repository = GameRepositoryImpl(datasource: gameDatasource);

      final Either<Failure, Stream<Game?>> result = ListenToGame(repository: repository).call(id: 'nonExistingId');

      expect(result.isRight(), true);

      expect(
        result.getOrElse(() => const Stream.empty()),
        emitsInOrder([isNull]),
      );

      await gameDatasource.loadSavedGames();
    });
  });
}
