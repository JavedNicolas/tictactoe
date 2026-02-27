import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoe/features/game_history/presentation/provider/game_history_notifier.dart';
import 'package:tictactoe/features/game_history/presentation/provider/game_history_state.dart';
import 'package:tictactoe/features/game_history/presentation/widget/game_history_tile.dart';
import 'package:tictactoe/shared/presentation/widget/loading_widget.dart';

@RoutePage()
class GameHistoryPage extends ConsumerWidget {
  const GameHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GameHistoryState state = ref.watch(gameHistoryNotifierProvider);
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.tr("pages.game_history.title"), style: theme.textTheme.titleSmall),
      ),
      body: Builder(builder: (context) {
        switch (state.status) {
          case GameHistoryStatus.error:
            return const Center(child: Text('Failed to load game history'));
          case GameHistoryStatus.loading:
            return const Center(child: LoadingWidget());
          case GameHistoryStatus.loaded:
            if (state.games.isEmpty) {
              return Center(child: Text(context.tr("pages.game_history.messages.empty")));
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: state.games.length,
              itemBuilder: (context, index) {
                return GameHistoryTile(game: state.games[index]);
              },
            );
        }
      }),
    );
  }
}
