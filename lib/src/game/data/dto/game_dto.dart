import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe/src/game/data/dto/cell_dto.dart';
import 'package:tictactoe/src/game/domain/entity/game.dart';

part 'game_dto.freezed.dart';
part 'game_dto.g.dart';

@freezed
abstract class GameDto with _$GameDto {
  const GameDto._();

  const factory GameDto({required String id, required int date, required List<CellDto> cells, required String status}) =
      _GameDto;

  factory GameDto.fromRawString(String raw) {
    final Map<String, dynamic> map = Map<String, dynamic>.from(jsonDecode(raw) as Map);

    return GameDto.fromJson(map);
  }

  factory GameDto.fromJson(Map<String, dynamic> map) => _$GameDtoFromJson(map);

  factory GameDto.fromGameState(Game gameState) {
    return GameDto(
      id: gameState.id,
      date: gameState.date.millisecondsSinceEpoch,
      cells: gameState.cells.map((cell) => CellDto.fromCell(cell)).toList(),
      status: gameState.status.name,
    );
  }

  String toRawString() => jsonEncode(toJson());
}
