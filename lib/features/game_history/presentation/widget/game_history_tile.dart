import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/features/game/domain/entity/game.dart';
import 'package:tictactoe/features/game/presentation/widget/tic_tac_toe_grid.dart';
import 'package:tictactoe/shared/presentation/widget/custom_button.dart';

class GameHistoryTile extends StatelessWidget {
  const GameHistoryTile({required this.game, super.key});

  final Game game;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)), color: theme.colorScheme.surface),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.tr('widgets.game_history_tile.title', args: [DateFormat.yMMMd().add_jm().format(game.date)]),
                  style: theme.textTheme.bodyMedium),
              Text(context.tr('widgets.game_history_tile.subtitle.${game.status.name}'),
                  style: theme.textTheme.bodySmall),
            ],
          ),
          if (game.isCompleted)
            CustomButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => Dialog(child: TicTacToeGrid(currentGame: game, readOnly: true)));
                },
                text: context.tr('widgets.game_history_tile.buttons.see'))
        ],
      ),
    );
  }
}
