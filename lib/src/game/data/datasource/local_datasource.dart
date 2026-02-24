import 'package:tictactoe/src/game/data/dto/game_dto.dart';

abstract class LocalDatasource {
  Future<List<GameDto>> loadSavedGames();
  Future<void> updateGameDto({required GameDto gameDto});
}
