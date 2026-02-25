import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoe/features/game_history/presentation/provider/game_history_notifier.dart';
import 'package:tictactoe/features/game_history/presentation/provider/game_history_state.dart';

@RoutePage()
class GameHistoryPage extends HookConsumerWidget {
  const GameHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GameHistoryState state = ref.watch(gameHistoryNotifierProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(gameHistoryNotifierProvider.notifier).loadGameHistory();
      });
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game History'),
      ),
      body: Builder(builder: (context) {
        switch (state.status) {
          case GameHistoryStatus.error:
            return const Center(child: Text('Failed to load game history'));
          case GameHistoryStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case GameHistoryStatus.loaded:
            if (state.games.isEmpty) {
              return const Center(child: Text('No games found'));
            }

            return ListView.builder(
              itemCount: state.games.length,
              itemBuilder: (context, index) {
                final game = state.games[index];
                return ListTile(
                  title: Text('Status: ${game.status.name}'),
                  subtitle: Text('Played at: ${game.date}'),
                );
              },
            );
        }
      }),
    );
  }
}
