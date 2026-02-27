import 'package:tictactoe/shared/extensions/list_extension.dart';

enum GameStatus {
  ongoing,
  draw,
  abandoned,
  player1,
  player2;

  factory GameStatus.fromString(String? value) {
    return GameStatus.values.firstWhereOrNull((state) => state.name == value) ?? GameStatus.ongoing;
  }

  bool get isOngoing => this == GameStatus.ongoing;
  bool get isDraw => this == GameStatus.draw;
  bool get isAbandoned => this == GameStatus.abandoned;
  bool get isPlayer1Win => this == GameStatus.player1;
  bool get isPlayer2Win => this == GameStatus.player2;
  bool get isCompleted => !isOngoing;
}
