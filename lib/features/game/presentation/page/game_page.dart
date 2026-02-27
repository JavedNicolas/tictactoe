import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/presentation/provider/game_state.dart';
import 'package:tictactoe/features/game/presentation/widget/end_game_dialog.dart';
import 'package:tictactoe/features/game/presentation/widget/tic_tac_toe_grid.dart';
import 'package:tictactoe/shared/presentation/widget/animated_sliding_widget.dart';
import 'package:tictactoe/shared/presentation/widget/custom_button.dart';
import 'package:tictactoe/shared/presentation/widget/custom_scaffold.dart';
import 'package:tictactoe/features/game/presentation/provider/game_notifier.dart';
import 'package:tictactoe/shared/presentation/widget/loading_widget.dart';

@RoutePage()
class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GameState gameState = ref.watch(gameNotifierProvider);
    final Game currentGame = gameState.currentGame;
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    if (gameState.isLoading) {
      return const CustomScaffold(body: Center(child: LoadingWidget()));
    }

    return CustomScaffold(
      overlay: currentGame.isCompleted ? EndGameDialog(gameStatus: currentGame.status) : null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Text(
            context.tr('pages.game.turns.player1'),
            style: theme.textTheme.displaySmall!.copyWith(color: colorScheme.primary),
          ),
          TicTacToeGrid(currentGame: currentGame),
        ],
      ),
      bottomNavigationBar: AnimatedSlidingWidget(
        direction: SlideDirection.up,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              onPressed: () {
                ref.watch(gameNotifierProvider.notifier).giveUpGame();
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
      ),
    );
  }
}
