import 'dart:math';
import 'package:tictactoe/shared/constant.dart';
import 'package:tictactoe/features/game/domain/entity/cell.dart';
import 'package:tictactoe/features/game/domain/entity/cell_state.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/entity/game_status.dart';
import 'package:tictactoe/features/game/domain/repository/game_repository.dart';

class MakeMove {
  const MakeMove();

  Future<void> call({
    required int index,
    required int playerIndex,
    required GameRepository repository,
    required Game game,
  }) async {
    final Game updatedGame = game.updateCell(index: index, playerIndex: playerIndex);
    final GameStatus status = _checkGameCompletion(updatedGame.cells);

    await repository.updateCurrentGame(game: updatedGame.updateStatus(status));

    if (status.isOngoing && playerIndex == 0) {
      await call(index: _getAiMoveIndex(updatedGame.cells), playerIndex: 1, repository: repository, game: updatedGame);
    }
  }

  int _getAiMoveIndex(List<Cell> cells) {
    final List<int> emptyIndices =
        cells.asMap().entries.where((entry) => entry.value.isEmpty).map((entry) => entry.key).toList();
    final Random random = Random();
    final int randomIndex = random.nextInt(emptyIndices.length);

    return emptyIndices[randomIndex];
  }

  GameStatus _checkGameCompletion(List<Cell> cells) {
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
        return firstCell.state == CellState.player1 ? GameStatus.player1Win : GameStatus.player2Win;
      }
    }

    if (cells.every((cell) => cell.isNotEmpty)) {
      return GameStatus.draw;
    }

    return GameStatus.ongoing;
  }
}
