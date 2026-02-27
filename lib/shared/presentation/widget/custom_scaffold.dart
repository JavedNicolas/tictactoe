import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({required this.body, this.bottomNavigationBar, this.overlay, super.key});

  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? overlay;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Scaffold(body: body, bottomNavigationBar: bottomNavigationBar),
            ),
          ),
        ),
        if (overlay != null) Positioned.fill(child: ColoredBox(color: theme.colorScheme.inverseSurface)),
        if (overlay != null) overlay!,
      ],
    );
  }
}
