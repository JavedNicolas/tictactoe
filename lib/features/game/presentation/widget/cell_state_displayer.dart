import 'package:flutter/material.dart';
import 'package:tictactoe/features/game/domain/entity/cell_state.dart';

class CellStateDisplayer extends StatelessWidget {
  const CellStateDisplayer({required this.cellState, super.key});

  final CellState cellState;

  @override
  Widget build(BuildContext context) {
    switch (cellState) {
      case CellState.empty:
        return const SizedBox.shrink();
      case CellState.player1:
        return const Image(image: AssetImage('assets/icons/player1.png'));
      case CellState.player2:
        return const Image(image: AssetImage('assets/icons/player2.png'));
    }
  }
}
