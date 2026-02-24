import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/src/game/data/dto/game_dto.dart';
import 'package:tictactoe/src/game/data/game_repository_impl.dart';
import 'package:tictactoe/src/game/domain/entity/game.dart';
import 'package:tictactoe/src/game/domain/entity/game_status.dart';
import 'package:tictactoe/src/game/domain/use_case/give_up_game.dart';

import '../../data/fake/fake_local_datasource.dart';
import '../../data/mocked_games_dto.dart';

void main() {
  group('GiveUpGame', () {
    test('given an ongoing game when GiveUpGame is called then game is marked abandoned and there is no current game',
        () async {
      final FakeLocalDatasource datasource = FakeLocalDatasource(
        savedGames: savedGameWithOngoing,
      );
      final GameStateRepositoryImpl repository = GameStateRepositoryImpl(datasource: datasource);

      final Game currentGame = Game.fromDto(savedGameWithOngoing[1]);
      await GiveUpGame().call(game: currentGame, gameRepository: repository);

      final Game? ongoingGame = await repository.getCurrentGame();
      final GameDto abandonedGame = datasource.games.firstWhere((game) => game.id == currentGame.id);

      expect(ongoingGame, isNull);
      expect(abandonedGame.id, currentGame.id);
      expect(abandonedGame.status, GameStatus.abandoned.name);
    });
  });
}
