import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/data/datasource/game_datasource.dart';
import 'package:tictactoe/shared/extensions/list_extension.dart';
import 'package:tictactoe/features/game/data/dto/game_dto.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/repository/game_repository.dart';

part 'game_repository_impl.g.dart';

@Riverpod(keepAlive: true)
GameRepository gameRepository(Ref ref) {
  final GameDatasource datasource = ref.watch(gameDatasourceProvider);

  return GameStateRepositoryImpl(datasource: datasource);
}

class GameStateRepositoryImpl implements GameRepository {
  GameStateRepositoryImpl({required GameDatasource datasource}) : _datasource = datasource;

  final GameDatasource _datasource;

  @override
  Future<List<Game>> loadSavedGames() async {
    final List<GameDto> gameStateDtos = await _datasource.loadSavedGames();

    return gameStateDtos.map((dto) => Game.fromDto(dto)).toList();
  }

  @override
  Future<void> updateCurrentGame({required Game game}) async {
    final GameDto gameStateDtos = GameDto.fromGameState(game);

    await _datasource.updateGameDto(gameDto: gameStateDtos);
  }

  @override
  Future<Game?> getOngoingGame() async {
    final List<Game> savedGames = await loadSavedGames();
    if (savedGames.isEmpty) {
      throw Exception('No saved games found');
    }

    return savedGames.firstWhereOrNull((game) => !game.isCompleted);
  }

  @override
  Future<Game?> getGame({required String gameId}) async {
    final List<Game> savedGames = await loadSavedGames();
    if (savedGames.isEmpty) {
      throw Exception('No saved games found');
    }

    return savedGames.firstWhereOrNull((game) => game.id == gameId);
  }
}
