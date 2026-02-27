import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoe/features/game/domain/entity/cell_state.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/presentation/provider/game_notifier.dart';
import 'package:tictactoe/features/game/presentation/provider/game_state.dart';
import 'package:tictactoe/features/game/presentation/widget/cell_state_displayer.dart';
import 'package:tictactoe/shared/constant.dart';

class TicTacToeGrid extends ConsumerWidget {
  const TicTacToeGrid({
    required this.currentGame,
    this.currentPlayer,
    this.readOnly = false,
    super.key,
  });

  final Game currentGame;
  final bool readOnly;
  final CurrentPlayer? currentPlayer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(kGridSizeBorderRadius),
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: kTicTacToeSize, mainAxisSpacing: 5, crossAxisSpacing: 5),
          itemCount: currentGame.cells.length,
          itemBuilder: (context, index) {
            final bool cantInteract = readOnly ||
                currentGame.cells[index].state != CellState.empty &&
                    currentPlayer != null &&
                    currentPlayer == CurrentPlayer.player1;
            final int column = (index) % kTicTacToeSize;
            final int row = (index / kTicTacToeSize).floor();
            final bool isCorner =
                (row == 0 || row == kTicTacToeSize - 1) && (column == 0 || column == kTicTacToeSize - 1);

            return Animate(
              effects: [
                ScaleEffect(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                    delay: Duration(milliseconds: 50 * index)),
              ],
              child: InkWell(
                onTap: cantInteract
                    ? null
                    : () {
                        ref.watch(gameNotifierProvider.notifier).makeMove(index: index, playerIndex: 0);
                      },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.only(
                      topLeft: isCorner && row == 0 && column == 0
                          ? const Radius.circular(kGridSizeBorderRadius * 0.8)
                          : Radius.zero,
                      topRight: isCorner && row == 0 && column == kTicTacToeSize - 1
                          ? const Radius.circular(kGridSizeBorderRadius * 0.8)
                          : Radius.zero,
                      bottomLeft: isCorner && row == kTicTacToeSize - 1 && column == 0
                          ? const Radius.circular(kGridSizeBorderRadius * 0.8)
                          : Radius.zero,
                      bottomRight: isCorner && row == kTicTacToeSize - 1 && column == kTicTacToeSize - 1
                          ? const Radius.circular(kGridSizeBorderRadius * 0.8)
                          : Radius.zero,
                    ),
                  ),
                  child: Center(
                      child: FittedBox(
                          child: Animate(effects: [
                    FadeEffect(duration: 200.ms, curve: Curves.easeInOut),
                    ScaleEffect(
                        duration: 1000.ms,
                        curve: Curves.easeInOut,
                        begin: const Offset(1.2, 1.2),
                        end: const Offset(1, 1)),
                  ], child: CellStateDisplayer(cellState: currentGame.cells[index].state)))),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
