import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe/src/game/data/datasource/local_datasource.dart';
import 'package:tictactoe/src/game/data/dto/game_dto.dart';

class SharedPrefsDatasource extends LocalDatasource {
  List<GameDto> _cachedGames = [];

  @override
  Future<List<GameDto>> loadSavedGames({required String ownerId}) async {
    if (_cachedGames.isNotEmpty) {
      return _cachedGames;
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? savedGames = prefs.getStringList(ownerId);
    final List<GameDto> games = savedGames?.map((gameString) => GameDto.fromRawString(gameString)).toList() ?? [];

    _setCachedGames(games);

    return games;
  }

  @override
  Future<void> updateGameState({required GameDto gameState, required String ownerId}) async {
    final List<GameDto> savedGames = await loadSavedGames(ownerId: ownerId);
    final List<GameDto> updatedGames = [...savedGames.where((game) => game.id != gameState.id), gameState];

    await _saveGames(games: updatedGames, ownerId: ownerId);
  }

  Future<void> _saveGames({required List<GameDto> games, required String ownerId}) async {
    _setCachedGames(games);

    final List<String> gameStateStrings = games.map((game) => game.toRawString()).toList();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(ownerId, gameStateStrings);
  }

  void _setCachedGames(List<GameDto> games) {
    _cachedGames = games;
  }
}
