import 'package:tictactoe/src/game/data/datasource/local_datasource.dart';
import 'package:tictactoe/src/game/data/dto/game_state_dto.dart';
import 'package:tictactoe/src/game/domain/entity/game_state.dart';
import 'package:tictactoe/src/game/domain/repository/game_state_repository.dart';

class GameStateRepositoryImpl implements GameStateRepository {
  GameStateRepositoryImpl({required LocalDatasource datasource}) : _datasource = datasource;

  final LocalDatasource _datasource;

  @override
  Future<List<GameState>> loadSavedGames(String ownerId) async {
    final List<GameStateDto> gameStateDtos = await _datasource.loadSavedGames(ownerId: ownerId);

    return gameStateDtos.map((dto) => GameState.fromDto(dto)).toList();
  }

  @override
  Future<void> updateCurrentGameState(GameState currentGameState, String ownerId) async {
    final GameStateDto gameStateDtos = GameStateDto.fromGameState(currentGameState);

    await _datasource.updateGameState(gameState: gameStateDtos, ownerId: ownerId);
  }

  @override
  Future<GameState> getCurrentGameState(String ownerId) async {
    final List<GameState> savedGames = await loadSavedGames(ownerId);
    if (savedGames.isEmpty) {
      throw Exception('No saved games found for ownerId: $ownerId');
    }

    return savedGames.firstWhere((game) => !game.isCompleted, orElse: () => savedGames.last);
  }
}
