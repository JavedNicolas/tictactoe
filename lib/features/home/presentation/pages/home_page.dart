import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoe/features/home/presentation/provider/home_page_notifier.dart';
import 'package:tictactoe/features/home/presentation/provider/home_state.dart';
import 'package:tictactoe/features/home/presentation/widget/animated_home_header.dart';
import 'package:tictactoe/shared/presentation/widget/animated_sliding_widget.dart';
import 'package:tictactoe/shared/presentation/widget/loading_widget.dart';
import 'package:tictactoe/shared/router/app_router.gr.dart';
import 'package:tictactoe/shared/presentation/widget/custom_button.dart';
import 'package:tictactoe/shared/presentation/widget/custom_scaffold.dart';

@RoutePage()
class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeState state = ref.watch(homePageNotifierProvider);
    final ThemeData theme = Theme.of(context);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (state.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.tr("pages.home.errors.load_games")),
            ),
          );
        }
      });
      return null;
    }, [state]);

    return CustomScaffold(
      body: Column(
        children: [
          const AnimatedHomeHeader(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.tr("pages.home.description"),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: AnimatedSlidingWidget(
        direction: SlideDirection.up,
        child: state.isLoading
            ? const LoadingWidget()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                spacing: 5,
                children: [
                  CustomButton(
                    icon: Icons.play_arrow,
                    text: state.hasOngoingGame
                        ? context.tr("pages.home.buttons.continue")
                        : context.tr("pages.home.buttons.start"),
                    onPressed: () {
                      context.router.push(const GameRoute());
                    },
                  ),
                  CustomButton(
                    icon: Icons.history,
                    text: context.tr("pages.home.buttons.history"),
                    onPressed: () {
                      context.router.push(const GameHistoryRoute());
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
