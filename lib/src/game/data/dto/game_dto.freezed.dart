// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GameDto {
  String get id;
  int get date;
  List<CellDto> get cells;
  String get status;

  /// Create a copy of GameDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GameDtoCopyWith<GameDto> get copyWith =>
      _$GameDtoCopyWithImpl<GameDto>(this as GameDto, _$identity);

  /// Serializes this GameDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GameDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other.cells, cells) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, date,
      const DeepCollectionEquality().hash(cells), status);

  @override
  String toString() {
    return 'GameDto(id: $id, date: $date, cells: $cells, status: $status)';
  }
}

/// @nodoc
abstract mixin class $GameDtoCopyWith<$Res> {
  factory $GameDtoCopyWith(GameDto value, $Res Function(GameDto) _then) =
      _$GameDtoCopyWithImpl;
  @useResult
  $Res call({String id, int date, List<CellDto> cells, String status});
}

/// @nodoc
class _$GameDtoCopyWithImpl<$Res> implements $GameDtoCopyWith<$Res> {
  _$GameDtoCopyWithImpl(this._self, this._then);

  final GameDto _self;
  final $Res Function(GameDto) _then;

  /// Create a copy of GameDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? cells = null,
    Object? status = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as int,
      cells: null == cells
          ? _self.cells
          : cells // ignore: cast_nullable_to_non_nullable
              as List<CellDto>,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _GameDto extends GameDto {
  const _GameDto(
      {required this.id,
      required this.date,
      required final List<CellDto> cells,
      required this.status})
      : _cells = cells,
        super._();
  factory _GameDto.fromJson(Map<String, dynamic> json) =>
      _$GameDtoFromJson(json);

  @override
  final String id;
  @override
  final int date;
  final List<CellDto> _cells;
  @override
  List<CellDto> get cells {
    if (_cells is EqualUnmodifiableListView) return _cells;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cells);
  }

  @override
  final String status;

  /// Create a copy of GameDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GameDtoCopyWith<_GameDto> get copyWith =>
      __$GameDtoCopyWithImpl<_GameDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GameDtoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GameDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other._cells, _cells) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, date,
      const DeepCollectionEquality().hash(_cells), status);

  @override
  String toString() {
    return 'GameDto(id: $id, date: $date, cells: $cells, status: $status)';
  }
}

/// @nodoc
abstract mixin class _$GameDtoCopyWith<$Res> implements $GameDtoCopyWith<$Res> {
  factory _$GameDtoCopyWith(_GameDto value, $Res Function(_GameDto) _then) =
      __$GameDtoCopyWithImpl;
  @override
  @useResult
  $Res call({String id, int date, List<CellDto> cells, String status});
}

/// @nodoc
class __$GameDtoCopyWithImpl<$Res> implements _$GameDtoCopyWith<$Res> {
  __$GameDtoCopyWithImpl(this._self, this._then);

  final _GameDto _self;
  final $Res Function(_GameDto) _then;

  /// Create a copy of GameDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? cells = null,
    Object? status = null,
  }) {
    return _then(_GameDto(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as int,
      cells: null == cells
          ? _self._cells
          : cells // ignore: cast_nullable_to_non_nullable
              as List<CellDto>,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
