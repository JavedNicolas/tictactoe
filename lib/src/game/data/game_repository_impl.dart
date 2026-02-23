import 'package:tictactoe/src/game/data/datasource/local_datasource.dart';
import 'package:tictactoe/src/game/data/dto/game_dto.dart';
import 'package:tictactoe/src/game/domain/entity/game.dart';
import 'package:tictactoe/src/game/domain/repository/game_repository.dart';

class GameStateRepositoryImpl implements GameStateRepository {
  GameStateRepositoryImpl({required LocalDatasource datasource}) : _datasource = datasource;

  final LocalDatasource _datasource;

  @override
  Future<List<Game>> loadSavedGames(String ownerId) async {
    final List<GameDto> gameStateDtos = await _datasource.loadSavedGames(ownerId: ownerId);

    return gameStateDtos.map((dto) => Game.fromDto(dto)).toList();
  }

  @override
  Future<void> updateCurrentGameState(Game currentGameState, String ownerId) async {
    final GameDto gameStateDtos = GameDto.fromGameState(currentGameState);

    await _datasource.updateGameState(gameState: gameStateDtos, ownerId: ownerId);
  }

  @override
  Future<Game> getCurrentGameState(String ownerId) async {
    final List<Game> savedGames = await loadSavedGames(ownerId);
    if (savedGames.isEmpty) {
      throw Exception('No saved games found for ownerId: $ownerId');
    }

    return savedGames.firstWhere((game) => !game.isCompleted, orElse: () => savedGames.last);
  }
}
