import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({required this.body, this.bottomNavigationBar, this.overlay, super.key});

  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? overlay;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return ColoredBox(
      color: colorScheme.surface,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset(
              "assets/images/background.png",
              fit: BoxFit.cover,
              color: colorScheme.surfaceContainerLow,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Scaffold(body: body, bottomNavigationBar: bottomNavigationBar),
            ),
          ),
          if (overlay != null) Positioned.fill(child: ColoredBox(color: colorScheme.surfaceContainerHigh)),
          if (overlay != null) overlay!,
        ],
      ),
    );
  }
}
