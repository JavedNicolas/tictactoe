import 'package:tictactoe/shared/extensions/list_extension.dart';

enum GameStateStatus {
  ongoing,
  draw,
  player1Win,
  player2Win;

  factory GameStateStatus.fromString(String? value) {
    return GameStateStatus.values.firstWhereOrNull((state) => state.name == value) ?? GameStateStatus.ongoing;
  }

  bool get isOngoing => this == GameStateStatus.ongoing;
  bool get isDraw => this == GameStateStatus.draw;
  bool get isPlayer1Win => this == GameStateStatus.player1Win;
  bool get isPlayer2Win => this == GameStateStatus.player2Win;
}
