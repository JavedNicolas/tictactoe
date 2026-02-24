import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoe/shared/constant.dart';
import 'package:tictactoe/shared/widgets/custom_button.dart';
import 'package:tictactoe/shared/widgets/custom_scaffold.dart';
import 'package:tictactoe/src/game/domain/entity/game.dart';
import 'package:tictactoe/src/game/presentation/provider/current_game_notifier/current_game_notifier.dart';
import 'package:tictactoe/src/game/presentation/widgets/cell_state_displayer.dart';

@RoutePage()
class GamePage extends HookConsumerWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Game gameState = ref.watch(currentGameNotifierProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (gameState.isCompleted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Game completed with status: ${gameState.status.name}')));
        }
      });

      return null;
    }, [gameState.status]);

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
                    ref.watch(currentGameNotifierProvider.notifier).makeMove(index: index, playerIndex: 0);
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
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (gameState.isCompleted)
            CustomButton(
              onPressed: () {
                ref.watch(currentGameNotifierProvider.notifier).startNewGame();
              },
              text: context.tr('pages.game.buttons.restart'),
            ),
          if (gameState.isOngoing)
            CustomButton(
              onPressed: () {
                ref.watch(currentGameNotifierProvider.notifier).giveUpGame();
                Navigator.of(context).pop();
              },
              text: context.tr('pages.game.buttons.give_up'),
            ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              context.tr('pages.game.buttons.back'),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
