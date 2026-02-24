import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/src/game/domain/entity/game_status.dart';

void main() {
  group('GameStatus', () {
    test('given valid status names when fromString is called then matching enum values are returned', () {
      expect(GameStatus.fromString('draw'), GameStatus.draw);
      expect(GameStatus.fromString('player1Win'), GameStatus.player1Win);
      expect(GameStatus.fromString('player2Win'), GameStatus.player2Win);
      expect(GameStatus.fromString('abandoned'), GameStatus.abandoned);
    });

    test('given null or invalid value when fromString is called then ongoing is returned', () {
      expect(GameStatus.fromString(null), GameStatus.ongoing);
      expect(GameStatus.fromString('invalid'), GameStatus.ongoing);
    });

    test('given each status when helper flags are read then only matching helper is true', () {
      expect(GameStatus.ongoing.isOngoing, isTrue);
      expect(GameStatus.draw.isDraw, isTrue);
      expect(GameStatus.abandoned.isAbandoned, isTrue);
      expect(GameStatus.player1Win.isPlayer1Win, isTrue);
      expect(GameStatus.player2Win.isPlayer2Win, isTrue);
      expect(GameStatus.draw.isOngoing, isFalse);
    });
  });
}
