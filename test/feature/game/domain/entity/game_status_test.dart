import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/features/game/domain/entity/game_status.dart';

void main() {
  group('GameStatus', () {
    test('given valid status names when fromString is called then matching enum values are returned', () {
      expect(GameStatus.fromString('draw'), GameStatus.draw);
      expect(GameStatus.fromString('player1Win'), GameStatus.player1);
      expect(GameStatus.fromString('player2Win'), GameStatus.player2);
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
      expect(GameStatus.player1.isPlayer1Win, isTrue);
      expect(GameStatus.player2.isPlayer2Win, isTrue);
      expect(GameStatus.draw.isOngoing, isFalse);
    });
  });
}
