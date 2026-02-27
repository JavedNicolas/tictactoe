import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:tictactoe/features/game/domain/entity/game_status.dart';
import 'package:tictactoe/features/game/presentation/provider/game_notifier.dart';
import 'package:tictactoe/shared/presentation/widget/custom_button.dart';

class EndGameDialog extends HookConsumerWidget {
  const EndGameDialog({required this.gameStatus, super.key});

  final GameStatus gameStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final AnimationController rotationController = useAnimationController(duration: 1000.ms)..forward();
    final bool isDraw = gameStatus == GameStatus.draw;
    const double imageSize = 70;

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          left: 0,
          right: 0,
          child: Animate(
              controller: rotationController,
              onComplete: (controller) => controller.loop(),
              effects: [
                RotateEffect(
                  duration: 5.seconds,
                ),
              ],
              child: Image.asset("assets/images/full_shine_faded.png")),
        ),
        Positioned(
          top: MediaQuery.sizeOf(context).height * 0.5 - (imageSize / 2),
          left: 0,
          right: 0,
          bottom: 30,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Animate(
                effects: [
                  FadeEffect(duration: 500.ms, curve: Curves.easeInOut),
                  ScaleEffect(duration: 500.ms, curve: Curves.easeInOut),
                ],
                child: Image.asset(
                  "assets/icons/${gameStatus.name}.png",
                  height: imageSize,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                context.tr('widgets.end_game_dialog.title.${gameStatus.name}'),
                style: theme.textTheme.headlineMedium!.copyWith(color: colorScheme.onInverseSurface),
              ),
              const Spacer(),
              CustomButton(
                onPressed: () {
                  ref.watch(gameNotifierProvider.notifier).startNewGame();
                },
                text: context.tr('widgets.end_game_dialog.buttons.restart'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  context.tr('widgets.end_game_dialog.buttons.back'),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colorScheme.onInverseSurface),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
