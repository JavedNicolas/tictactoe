// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GameDto _$GameDtoFromJson(Map<String, dynamic> json) => _GameDto(
      id: json['id'] as String,
      date: (json['date'] as num).toInt(),
      cells: (json['cells'] as List<dynamic>)
          .map((e) => CellDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$GameDtoToJson(_GameDto instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'cells': instance.cells,
      'status': instance.status,
    };
