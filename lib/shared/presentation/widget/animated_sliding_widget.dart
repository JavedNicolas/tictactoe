import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tictactoe/shared/constant.dart';

enum SlideDirection { up, down }

class AnimatedSlidingWidget extends StatelessWidget {
  const AnimatedSlidingWidget({
    required this.child,
    required this.direction,
    this.duration = kHomePageElementDisplayDuration,
    this.offsetMultiplier = 150,
    this.onComplete,
    super.key,
  });

  final Widget child;
  final SlideDirection direction;
  final Duration duration;
  final double offsetMultiplier;
  final void Function(AnimationController)? onComplete;

  @override
  Widget build(BuildContext context) {
    final Offset beginOffset =
        direction == SlideDirection.up ? Offset(0, offsetMultiplier) : Offset(0, -offsetMultiplier);
    return Animate(
        onComplete: onComplete,
        effects: [
          FadeEffect(duration: kHomePageElementDisplayDuration ~/ 2, curve: Curves.easeOut),
          MoveEffect(
            begin: beginOffset,
            end: const Offset(0, 0),
            duration: kHomePageElementDisplayDuration,
            curve: Curves.fastEaseInToSlowEaseOut,
          ),
        ],
        child: child);
  }
}
