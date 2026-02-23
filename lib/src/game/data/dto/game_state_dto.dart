import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe/src/game/domain/entity/game_state.dart';

part 'game_state_dto.freezed.dart';
part 'game_state_dto.g.dart';

@freezed
abstract class GameStateDto with _$GameStateDto {
  const GameStateDto._();

  const factory GameStateDto({
    required String id,
    required int date,
    required List<String> cells,
    required bool isCompleted,
  }) = _GameStateDto;

  factory GameStateDto.fromRawString(String raw) {
    final Map<String, dynamic> map = Map<String, dynamic>.from(jsonDecode(raw) as Map);

    return GameStateDto.fromJson(map);
  }

  factory GameStateDto.fromJson(Map<String, dynamic> map) => _$GameStateDtoFromJson(map);

  factory GameStateDto.fromGameState(GameState gameState) {
    return GameStateDto(
      id: gameState.id,
      date: gameState.date.millisecondsSinceEpoch,
      cells: gameState.cells,
      isCompleted: gameState.isCompleted,
    );
  }

  String toRawString() => jsonEncode(toJson());
}
