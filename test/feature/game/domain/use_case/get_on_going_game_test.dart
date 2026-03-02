import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/features/game/data/datasource/game_datasource.dart';
import 'package:tictactoe/features/game/data/game_repository_impl.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/entity/game_status.dart';
import 'package:tictactoe/features/game/domain/use_case/get_on_going_game.dart';
import 'package:tictactoe/shared/errors/failure.dart';

import '../../data/fake/fake_local_datasource_service.dart';
import '../../data/mocked_games_dto.dart';

void main() {
  group('GetOnGoingGame', () {
    test('given multiple games with one ongoing when called then returns the ongoing game', () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(savedGames: savedGameWithOngoing);
      final GameRepositoryImpl repository =
          GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      final Either<Failure, Game?> result = await GetOnGoingGame(repository: repository).call();

      expect(result.isRight(), true);

      final Game? ongoingGame = result.getOrElse(() => null);
      expect(ongoingGame, isNotNull);
      expect(ongoingGame!.status, GameStatus.ongoing);
      expect(ongoingGame.id, savedGameWithOngoing[1].id);
    });

    test('given no games when called then returns null', () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(savedGames: []);
      final GameRepositoryImpl repository =
          GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      final Either<Failure, Game?> result = await GetOnGoingGame(repository: repository).call();

      expect(result.isRight(), true);

      final Game? ongoingGame = result.getOrElse(() => null);
      expect(ongoingGame, isNull);
    });

    test('given multiple completed games and no ongoing when called then returns null', () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(savedGames: saveGameOnlyCompleted);
      final GameRepositoryImpl repository =
          GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      final Either<Failure, Game?> result = await GetOnGoingGame(repository: repository).call();

      expect(result.isRight(), true);

      final Game? ongoingGame = result.getOrElse(() => null);
      expect(ongoingGame, isNull);
    });
  });
}
