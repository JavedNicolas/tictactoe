import 'dart:math';
import 'package:tictactoe/shared/constant.dart';
import 'package:tictactoe/src/game/domain/entity/cell.dart';
import 'package:tictactoe/src/game/domain/entity/game_state.dart';
import 'package:tictactoe/src/game/domain/repository/game_state_repository.dart';

class MakeMove {
  Future<void> call({
    required int index,
    required int playerIndex,
    required String ownerId,
    required GameStateRepository repository,
    required GameState gameState,
  }) async {
    final List<Cell> updatedCells = List.from(gameState.cells);
    updatedCells[index] = updatedCells[index].updateStateFromPlayerIndex(playerIndex: playerIndex);
    final bool isCompleted = _checkGameCompletion(updatedCells);

    final GameState updatedGame = GameState(
      id: gameState.id,
      date: DateTime.now(),
      cells: updatedCells,
      isCompleted: isCompleted,
    );

    await repository.updateCurrentGameState(updatedGame, ownerId);

    if (!isCompleted && playerIndex == 0) {
      await call(
        index: _getAiMoveIndex(updatedCells),
        playerIndex: 1,
        ownerId: ownerId,
        repository: repository,
        gameState: updatedGame,
      );
    }
  }

  int _getAiMoveIndex(List<Cell> cells) {
    final List<int> emptyIndices = cells
        .asMap()
        .entries
        .where((entry) => entry.value.isEmpty)
        .map((entry) => entry.key)
        .toList();
    final Random random = Random();
    final int randomIndex = random.nextInt(emptyIndices.length);

    return emptyIndices[randomIndex];
  }

  bool _checkGameCompletion(List<Cell> cells) {
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
        return true;
      }
    }

    return false;
  }
}
