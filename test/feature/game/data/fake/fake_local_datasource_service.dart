import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/features/game/data/dto/game_dto.dart';
import 'package:tictactoe/shared/service/local_database_service.dart';

class FakeLocalDatasourceService extends Fake implements LocalDatabaseService {
  FakeLocalDatasourceService({List<GameDto> savedGames = const []}) : games = savedGames;

  List<GameDto> games = [];

  @override
  Future<Object?> read({required String key}) async {
    return games.map((game) => game.toRawString()).toList();
  }

  @override
  Future<void> write({required String key, required Object value}) async {
    games = (value as List<String>).map((gameString) => GameDto.fromRawString(gameString)).toList();
  }
}
