import 'package:tictactoe/src/game/data/datasource/local_datasource.dart';
import 'package:tictactoe/src/game/data/dto/game_dto.dart';
import 'package:tictactoe/src/game/domain/entity/game.dart';
import 'package:tictactoe/src/game/domain/repository/game_repository.dart';

class GameStateRepositoryImpl implements GameRepository {
  GameStateRepositoryImpl({required LocalDatasource datasource}) : _datasource = datasource;

  final LocalDatasource _datasource;

  @override
  Future<List<Game>> loadSavedGames() async {
    final List<GameDto> gameStateDtos = await _datasource.loadSavedGames();

    return gameStateDtos.map((dto) => Game.fromDto(dto)).toList();
  }

  @override
  Future<void> updateCurrentGameState({required Game game}) async {
    final GameDto gameStateDtos = GameDto.fromGameState(game);

    await _datasource.updateGameState(gameState: gameStateDtos);
  }

  @override
  Future<Game> getCurrentGameState() async {
    final List<Game> savedGames = await loadSavedGames();
    if (savedGames.isEmpty) {
      throw Exception('No saved games found');
    }

    return savedGames.firstWhere((game) => !game.isCompleted, orElse: () => savedGames.last);
  }
}
