import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/domain/entity/game_status.dart';
import 'package:tictactoe/features/game/presentation/provider/game_notifier.dart';
import 'package:tictactoe/features/game/presentation/widget/cell_state_displayer.dart';
import 'package:tictactoe/shared/constant.dart';

class TicTacToeGrid extends ConsumerWidget {
  const TicTacToeGrid({
    required this.currentGame,
    this.readOnly = false,
    super.key,
  });

  final Game currentGame;
  final bool readOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return AspectRatio(
      aspectRatio: 1,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: kTicTacToeSize, mainAxisSpacing: 5, crossAxisSpacing: 5),
        itemCount: currentGame.cells.length,
        itemBuilder: (context, index) {
          final int column = (index) % kTicTacToeSize;
          final int row = (index / kTicTacToeSize).floor();
          final bool isCorner =
              (row == 0 || row == kTicTacToeSize - 1) && (column == 0 || column == kTicTacToeSize - 1);

          Color borderColor = kBorderColor;
          double borderWidth = 1;
          if (currentGame.winningCombination?.contains(index) == true) {
            borderColor = currentGame.status == GameStatus.player1Win ? kPlayer1Color : kPlayer2Color;
            borderWidth = 4;
          }

          return Animate(
            effects: [
              ScaleEffect(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  delay: Duration(milliseconds: 50 * index)),
            ],
            child: InkWell(
              onTap: readOnly
                  ? null
                  : () {
                      ref.watch(gameNotifierProvider.notifier).makeMove(index: index, playerIndex: 0);
                    },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.only(
                    topLeft: isCorner && row == 0 && column == 0 ? const Radius.circular(12) : Radius.zero,
                    topRight:
                        isCorner && row == 0 && column == kTicTacToeSize - 1 ? const Radius.circular(12) : Radius.zero,
                    bottomLeft:
                        isCorner && row == kTicTacToeSize - 1 && column == 0 ? const Radius.circular(12) : Radius.zero,
                    bottomRight: isCorner && row == kTicTacToeSize - 1 && column == kTicTacToeSize - 1
                        ? const Radius.circular(12)
                        : Radius.zero,
                  ),
                  border: Border.all(color: borderColor, width: borderWidth),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.outline,
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Center(child: FittedBox(child: CellStateDisplayer(cellState: currentGame.cells[index].state))),
              ),
            ),
          );
        },
      ),
    );
  }
}
