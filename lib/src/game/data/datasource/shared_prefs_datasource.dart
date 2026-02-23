import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe/src/game/data/datasource/local_datasource.dart';
import 'package:tictactoe/src/game/data/dto/game_dto.dart';

class SharedPrefsDatasource extends LocalDatasource {
  List<GameDto> _cachedGames = [];
  final String _gameKey = 'savedGames';

  @override
  Future<List<GameDto>> loadSavedGames() async {
    if (_cachedGames.isNotEmpty) {
      return _cachedGames;
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? savedGames = prefs.getStringList(_gameKey);
    final List<GameDto> games = savedGames?.map((gameString) => GameDto.fromRawString(gameString)).toList() ?? [];

    _setCachedGames(games);

    return games;
  }

  @override
  Future<void> updateGameState({required GameDto gameState}) async {
    final List<GameDto> savedGames = await loadSavedGames();
    final List<GameDto> updatedGames = [...savedGames.where((game) => game.id != gameState.id), gameState];

    await _saveGames(games: updatedGames);
  }

  Future<void> _saveGames({required List<GameDto> games}) async {
    _setCachedGames(games);

    final List<String> gameStateStrings = games.map((game) => game.toRawString()).toList();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(_gameKey, gameStateStrings);
  }

  void _setCachedGames(List<GameDto> games) {
    _cachedGames = games;
  }
}
