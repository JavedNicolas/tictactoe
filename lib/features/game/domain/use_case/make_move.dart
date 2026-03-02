import 'dart:math';
import 'package:dartz/dartz.dart';
import 'package:tictactoe/features/game/domain/entity/game_completion_state.dart';
import 'package:tictactoe/shared/constant.dart';
import 'package:tictactoe/features/game/domain/entity/cell.dart';
import 'package:tictactoe/features/game/domain/entity/cell_state.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/entity/game_status.dart';
import 'package:tictactoe/features/game/domain/repository/game_repository.dart';
import 'package:tictactoe/shared/errors/failure.dart';

class MakeMove {
  const MakeMove({required this.repository});

  final GameRepository repository;

  Future<Either<Failure, void>> callAi({
    required Game game,
  }) async {
    final int index = _getAiMoveIndex(game.cells);
    return await call(index: index, playerIndex: 1, game: game);
  }

  Future<Either<Failure, void>> call({
    required int index,
    required int playerIndex,
    required Game game,
  }) async {
    final Game updatedGame = game.updateCell(index: index, playerIndex: playerIndex);
    final GameCompletionState status = _checkGameCompletion(updatedGame.cells);

    if (status.status.isCompleted) {
      return await repository.updateGame(
          game: updatedGame.setCompleted(status.status, winningCombination: status.winningCombination));
    }

    return await repository.updateGame(game: updatedGame);
  }

  int _getAiMoveIndex(List<Cell> cells) {
    final List<int> emptyIndices =
        cells.asMap().entries.where((entry) => entry.value.isEmpty).map((entry) => entry.key).toList();
    final Random random = Random();
    final int randomIndex = random.nextInt(emptyIndices.length);

    return emptyIndices[randomIndex];
  }

  GameCompletionState _checkGameCompletion(List<Cell> cells) {
    final List<List<int>> winningCombinations = [
      // lines
      ...List.generate(
        kTicTacToeSize,
        (lineIndex) => List.generate(kTicTacToeSize, (colIndex) => lineIndex * kTicTacToeSize + colIndex),
      ),
      // columns
      ...List.generate(
        kTicTacToeSize,
        (colIndex) => List.generate(kTicTacToeSize, (lineIndex) => lineIndex * kTicTacToeSize + colIndex),
      ),
      // diagonals
      List.generate(kTicTacToeSize, (index) => index + kTicTacToeSize * index),
      List.generate(kTicTacToeSize, (index) => kTicTacToeSize * (index + 1) - (index + 1)),
    ];

    for (final combination in winningCombinations) {
      final Cell firstCell = cells[combination[0]];
      if (firstCell.isNotEmpty && combination.every((index) => cells[index].state.compare(firstCell.state))) {
        return GameCompletionState(firstCell.state == CellState.player1 ? GameStatus.player1 : GameStatus.player2,
            winningCombination: combination);
      }
    }

    if (cells.every((cell) => cell.isNotEmpty)) {
      return const GameCompletionState(GameStatus.draw);
    }

    return const GameCompletionState(GameStatus.ongoing);
  }
}
