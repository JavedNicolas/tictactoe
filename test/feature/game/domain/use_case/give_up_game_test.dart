import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/features/game/data/datasource/game_datasource.dart';
import 'package:tictactoe/features/game/data/dto/game_dto.dart';
import 'package:tictactoe/features/game/data/game_repository_impl.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/entity/game_status.dart';
import 'package:tictactoe/features/game/domain/use_case/give_up_game.dart';

import '../../data/fake/fake_local_datasource_service.dart';
import '../../data/mocked_games_dto.dart';

void main() {
  group('GiveUpGame', () {
    test('given an ongoing game when GiveUpGame is called then game is marked abandoned and there is no current game',
        () async {
      final FakeLocalDatasourceService datasource = FakeLocalDatasourceService(
        savedGames: savedGameWithOngoing,
      );
      final GameRepositoryImpl repository =
          GameRepositoryImpl(datasource: GameDatasource(localDatabaseService: datasource));

      final Game currentGame = Game.fromDto(savedGameWithOngoing[1]);
      await GiveUpGame(repository: repository).call(game: currentGame);

      final Game? ongoingGame = await repository.getOngoingGame();
      final GameDto abandonedGame = datasource.games.firstWhere((game) => game.id == currentGame.id);

      expect(ongoingGame, isNull);
      expect(abandonedGame.id, currentGame.id);
      expect(abandonedGame.status, GameStatus.abandoned.name);
    });
  });
}
