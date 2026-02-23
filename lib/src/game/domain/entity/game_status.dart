import 'package:tictactoe/shared/extensions/list_extension.dart';

enum GameStatus {
  ongoing,
  draw,
  player1Win,
  player2Win;

  factory GameStatus.fromString(String? value) {
    return GameStatus.values.firstWhereOrNull((state) => state.name == value) ?? GameStatus.ongoing;
  }

  bool get isOngoing => this == GameStatus.ongoing;
  bool get isDraw => this == GameStatus.draw;
  bool get isPlayer1Win => this == GameStatus.player1Win;
  bool get isPlayer2Win => this == GameStatus.player2Win;
}
