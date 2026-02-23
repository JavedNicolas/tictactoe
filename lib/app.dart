import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/shared/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Morpion',
      theme: lightTheme,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
