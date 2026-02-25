import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
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
    return AspectRatio(
      aspectRatio: 1,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: kTicTacToeSize),
        itemCount: currentGame.cells.length,
        itemBuilder: (context, index) {
          final int column = (index) % kTicTacToeSize;
          final int row = (index / kTicTacToeSize).floor();

          return InkWell(
            onTap: readOnly
                ? null
                : () {
                    ref.watch(gameNotifierProvider.notifier).makeMove(index: index, playerIndex: 0);
                  },
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  left: column == 0 ? const BorderSide(color: Colors.black) : BorderSide.none,
                  right: const BorderSide(color: Colors.black),
                  top: row == 0 ? const BorderSide(color: Colors.black) : BorderSide.none,
                  bottom: const BorderSide(color: Colors.black),
                ),
              ),
              child: Center(child: CellStateDisplayer(cellState: currentGame.cells[index].state)),
            ),
          );
        },
      ),
    );
  }
}
