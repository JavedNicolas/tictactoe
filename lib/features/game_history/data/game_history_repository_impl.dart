import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/data/datasource/game_datasource.dart';
import 'package:tictactoe/features/game/data/dto/game_dto.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game_history/domain/repository/game_history_repository.dart';
import 'package:tictactoe/shared/errors/failure.dart';

part 'game_history_repository_impl.g.dart';

@Riverpod(keepAlive: true)
GameHistoryRepository gameHistoryRepository(Ref ref) {
  final datasource = ref.watch(gameDatasourceProvider);
  return GameHistoryRepositoryImpl(datasource: datasource);
}

class GameHistoryRepositoryImpl implements GameHistoryRepository {
  GameHistoryRepositoryImpl({required GameDatasource datasource}) : _datasource = datasource;

  final GameDatasource _datasource;

  @override
  Future<Either<Failure, List<Game>>> getGameHistory() async {
    try {
      final List<GameDto> games = await _datasource.loadSavedGames();

      return Right(games.map((gameDto) => gameDto.toGame()).toList());
    } catch (e) {
      return Left(DatabaseQueryFailure());
    }
  }
}
