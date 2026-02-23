// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GameStateDto _$GameStateDtoFromJson(Map<String, dynamic> json) =>
    _GameStateDto(
      id: json['id'] as String,
      date: (json['date'] as num).toInt(),
      cells: (json['cells'] as List<dynamic>)
          .map((e) => CellDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      isCompleted: json['isCompleted'] as bool,
    );

Map<String, dynamic> _$GameStateDtoToJson(_GameStateDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'cells': instance.cells,
      'isCompleted': instance.isCompleted,
    };
