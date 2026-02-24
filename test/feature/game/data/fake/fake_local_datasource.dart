import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/src/game/data/datasource/local_datasource.dart';
import 'package:tictactoe/src/game/data/dto/game_dto.dart';

class FakeLocalDatasource extends Fake implements LocalDatasource {
  FakeLocalDatasource({List<GameDto> savedGames = const []}) : games = savedGames;

  List<GameDto> games = [];

  @override
  Future<List<GameDto>> loadSavedGames() {
    return Future.value(games);
  }

  @override
  Future<void> updateGameDto({required GameDto gameDto}) {
    final List<GameDto> updatedGames = [...games.where((game) => game.id != gameDto.id), gameDto];
    games = updatedGames;

    return Future.value();
  }
}
