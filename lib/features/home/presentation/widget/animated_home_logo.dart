import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tictactoe/shared/constant.dart';

class AnimatedHomeHeader extends StatefulWidget {
  const AnimatedHomeHeader({super.key});

  @override
  State<AnimatedHomeHeader> createState() => _AnimatedHomeHeaderState();
}

class _AnimatedHomeHeaderState extends State<AnimatedHomeHeader> with SingleTickerProviderStateMixin {
  late final AnimationController _loopAnimationController;

  @override
  void initState() {
    super.initState();
    _loopAnimationController = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Animate(
      controller: _loopAnimationController,
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
      child: Animate(
        onComplete: (controller) => _loopAnimationController.loop(),
        effects: [
          FadeEffect(duration: kHomePageElementDisplayDuration ~/ 2, curve: Curves.easeOut),
          const MoveEffect(
              begin: Offset(0, -150),
              end: Offset(0, 0),
              duration: kHomePageElementDisplayDuration,
              curve: Curves.fastEaseInToSlowEaseOut),
        ],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/gifs/animated_icon.gif', width: 120),
            Text(context.tr("pages.game_home.title"), style: theme.textTheme.displayLarge),
          ],
        ),
      ),
    );
  }
}
