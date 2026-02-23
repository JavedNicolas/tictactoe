import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/shared/constant.dart';
import 'package:tictactoe/shared/widgets/custom_scaffold.dart';
import 'package:tictactoe/src/game/domain/entity/game_state.dart';
import 'package:tictactoe/src/game/presentation/provider/current_game_notifier/current_game_state_notifier.dart';
import 'package:tictactoe/src/game/presentation/widgets/game_cell_content.dart';

@RoutePage()
class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GameState gameState = ref.watch(currentGameStateNotifierProvider).gameState;

    return CustomScaffold(
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: kTicTacToeSize),
              itemCount: gameState.cells.length,
              itemBuilder: (context, index) {
                final int column = (index) % kTicTacToeSize;
                final int row = (index / kTicTacToeSize).floor();

                return InkWell(
                  onTap: () {
                    ref
                        .watch(currentGameStateNotifierProvider.notifier)
                        .makeMove(
                          index: index,
                          playerIndex: 0,
                          ownerId: 'ownerId',
                        ); // Replace with actual ownerId and symbol
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
                    child: Center(child: CellStateDisplayer(cellState: gameState.cells[index].state)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          ref.watch(currentGameStateNotifierProvider.notifier).startNewGame('ownerId'); // Replace with actual ownerId
        },
        child: const Text('Start New Game'),
      ),
    );
  }
}
