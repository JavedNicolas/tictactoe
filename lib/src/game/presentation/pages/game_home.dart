import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/shared/widgets/custom_button.dart';
import 'package:tictactoe/shared/widgets/custom_scaffold.dart';

@RoutePage()
class GameHome extends StatelessWidget {
  const GameHome({super.key});

  @override
  Widget build(BuildContext context) {
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
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [CustomButton(icon: Icons.play_arrow, text: 'Start playing', onPressed: () {})],
      ),
    );
  }
}
