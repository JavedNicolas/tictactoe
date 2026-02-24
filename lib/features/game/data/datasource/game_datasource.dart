import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/data/dto/game_dto.dart';
import 'package:tictactoe/shared/presentation/provider.dart';
import 'package:tictactoe/shared/service/local_database_service.dart';

part 'game_datasource.g.dart';

@Riverpod(keepAlive: true)
GameDatasource gameDatasource(Ref ref) {
  final LocalDatabaseService localDatabaseService = ref.watch(localDatabaseServiceProvider);

  return GameDatasource(localDatabaseService: localDatabaseService);
}

class GameDatasource {
  GameDatasource({required LocalDatabaseService localDatabaseService}) : _localDatabaseService = localDatabaseService;

  List<GameDto> _cachedGames = [];
  final String _gameKey = 'savedGames';
  final LocalDatabaseService _localDatabaseService;

  Future<List<GameDto>> loadSavedGames() async {
    if (_cachedGames.isNotEmpty) {
      return _cachedGames;
    }

    final List<String>? savedGames = await _localDatabaseService.read(key: _gameKey) as List<String>?;
    final List<GameDto> games = savedGames?.map((gameString) => GameDto.fromRawString(gameString)).toList() ?? [];

    _setCachedGames(games);

    return games;
  }

  Future<void> updateGameDto({required GameDto gameDto}) async {
    final List<GameDto> savedGames = await loadSavedGames();
    final List<GameDto> updatedGames = [...savedGames.where((game) => game.id != gameDto.id), gameDto];

    await _saveGames(games: updatedGames);
  }

  Future<void> _saveGames({required List<GameDto> games}) async {
    _setCachedGames(games);

    final List<String> gameStateStrings = games.map((game) => game.toRawString()).toList();
    await _localDatabaseService.write(key: _gameKey, value: gameStateStrings);
  }

  void _setCachedGames(List<GameDto> games) {
    _cachedGames = games;
  }
}
