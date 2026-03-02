import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/features/game/data/datasource/game_datasource.dart';
import 'package:tictactoe/shared/errors/failure.dart';
import 'package:tictactoe/shared/extensions/list_extension.dart';
import 'package:tictactoe/features/game/data/dto/game_dto.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/repository/game_repository.dart';

part 'game_repository_impl.g.dart';

@Riverpod(keepAlive: true)
GameRepository gameRepository(Ref ref) {
  final GameDatasource datasource = ref.watch(gameDatasourceProvider);

  return GameRepositoryImpl(datasource: datasource);
}

class GameRepositoryImpl implements GameRepository {
  GameRepositoryImpl({required GameDatasource datasource}) : _datasource = datasource;

  final GameDatasource _datasource;

  @override
  Either<Failure, Stream<List<Game>>> listenToGames() {
    try {
      final Stream<List<GameDto>> stream = _datasource.subscribeToGameDtosStream();

      return Right(stream.map((gameDtos) => gameDtos.map((dto) => Game.fromDto(dto)).toList()));
    } catch (e) {
      return Left(DatabaseQueryFailure());
    }
  }

  @override
  Future<Either<Failure, List<Game>>> loadSavedGames() async {
    try {
      final List<GameDto> gameStateDtos = await _datasource.loadSavedGames();

      return Right(gameStateDtos.map((dto) => Game.fromDto(dto)).toList());
    } catch (e) {
      return Left(DatabaseQueryFailure());
    }
  }

  @override
  Future<Either<Failure, Game?>> getOngoingGame() async {
    try {
      final Either<Failure, List<Game>> either = await loadSavedGames();

      if (either.isLeft()) {
        return Left(either.swap().getOrElse(() => DatabaseQueryFailure()));
      }

      final List<Game> savedGames = either.getOrElse(() => []);
      return Right(savedGames.firstWhereOrNull((game) => !game.isCompleted));
    } catch (e) {
      return Left(DatabaseQueryFailure());
    }
  }

  @override
  Future<Either<Failure, Game?>> getGame({required String gameId}) async {
    try {
      final Either<Failure, List<Game>> either = await loadSavedGames();
      if (either.isLeft()) {
        return Left(either.swap().getOrElse(() => DatabaseQueryFailure()));
      }
      final List<Game> savedGames = either.getOrElse(() => []);

      return Right(savedGames.firstWhereOrNull((game) => game.id == gameId));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DatabaseQueryFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addGame({required Game game}) async {
    try {
      final GameDto gameStateDtos = GameDto.fromGameState(game);
      await _datasource.addGameDto(gameDto: gameStateDtos);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseQueryFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateGame({required Game game}) async {
    try {
      final GameDto gameStateDtos = GameDto.fromGameState(game);

      await _datasource.updateGameDto(gameDto: gameStateDtos);
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DatabaseQueryFailure());
    }
  }

  @override
  void dispose() {
    _datasource.dispose();
  }
}
