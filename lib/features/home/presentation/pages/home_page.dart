import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoe/features/home/presentation/provider/home_page_notifier.dart';
import 'package:tictactoe/features/home/presentation/provider/home_state.dart';
import 'package:tictactoe/shared/router/app_router.gr.dart';
import 'package:tictactoe/shared/presentation/widgets/custom_button.dart';
import 'package:tictactoe/shared/presentation/widgets/custom_scaffold.dart';

@RoutePage()
class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeState state = ref.watch(homePageNotifierProvider);
    final ThemeData theme = Theme.of(context);

    return CustomScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16,
        children: [
          Text(context.tr("pages.game_home.title"), style: theme.textTheme.displaySmall),
          Text(
            context.tr("pages.game_home.description"),
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 5,
        children: [
          CustomButton(
            isLoading: state.isLoading,
            icon: Icons.play_arrow,
            text: state.hasOngoingGame
                ? context.tr("pages.game_home.buttons.continue")
                : context.tr("pages.game_home.buttons.start"),
            onPressed: () {
              context.router.push(const GameRoute());
            },
          ),
          CustomButton(
            icon: Icons.history,
            text: context.tr("pages.game_home.buttons.history"),
            onPressed: () {
              context.router.push(const GameHistoryRoute());
            },
          ),
        ],
      ),
    );
  }
}
