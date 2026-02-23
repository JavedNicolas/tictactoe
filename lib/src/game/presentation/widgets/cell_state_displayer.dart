import 'package:flutter/material.dart';
import 'package:tictactoe/src/game/domain/entity/cell_state.dart';

class CellStateDisplayer extends StatelessWidget {
  const CellStateDisplayer({required this.cellState, super.key});

  final CellState cellState;

  @override
  Widget build(BuildContext context) {
    switch (cellState) {
      case CellState.empty:
        return const SizedBox.shrink();
      case CellState.player1:
        return const Text('X', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold));
      case CellState.player2:
        return const Text('O', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold));
    }
  }
}
