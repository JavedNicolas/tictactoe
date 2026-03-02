import 'package:dartz/dartz.dart';
import 'package:tictactoe/features/game/domain/repository/game_repository.dart';
import 'package:tictactoe/shared/errors/failure.dart';

class HasOngoingGame {
  const HasOngoingGame({required this.repository});

  final GameRepository repository;

  Either<Failure, Stream<bool>> call() {
    return repository.listenToGames().fold(
          (failure) => Left(failure),
          (stream) => Right(stream.map((games) => games.any((game) => game.isOngoing))),
        );
  }
}
