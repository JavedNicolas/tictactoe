import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:tictactoe/shared/constant.dart';
import 'package:tictactoe/shared/presentation/widget/animated_sliding_widget.dart';

class AnimatedHomeHeader extends HookConsumerWidget {
  const AnimatedHomeHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final AnimationController loopAnimationController =
        useAnimationController(duration: (kHomePageElementDisplayDuration * 2) ~/ 3);

    return Animate(
      controller: loopAnimationController,
      autoPlay: false,
      effects: [
        const MoveEffect(
          begin: Offset(0, 3),
          end: Offset(0, -3),
          duration: kHomePageElementDisplayDuration,
        ),
        const ThenEffect(),
        const MoveEffect(
            begin: Offset(0, -3),
            end: Offset(0, 3),
            duration: kHomePageElementDisplayDuration,
            curve: Curves.fastEaseInToSlowEaseOut),
      ],
      child: AnimatedSlidingWidget(
        direction: SlideDirection.down,
        onComplete: (controller) => loopAnimationController.loop(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset('assets/lottie/animated_icon.json'),
            Text(context.tr("widgets.animated_home_header.title"), style: theme.textTheme.displayLarge),
          ],
        ),
      ),
    );
  }
}
