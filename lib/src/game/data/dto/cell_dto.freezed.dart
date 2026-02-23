// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cell_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CellDto {
  int get index;
  String get state;

  /// Create a copy of CellDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CellDtoCopyWith<CellDto> get copyWith =>
      _$CellDtoCopyWithImpl<CellDto>(this as CellDto, _$identity);

  /// Serializes this CellDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CellDto &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.state, state) || other.state == state));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, index, state);

  @override
  String toString() {
    return 'CellDto(index: $index, state: $state)';
  }
}

/// @nodoc
abstract mixin class $CellDtoCopyWith<$Res> {
  factory $CellDtoCopyWith(CellDto value, $Res Function(CellDto) _then) =
      _$CellDtoCopyWithImpl;
  @useResult
  $Res call({int index, String state});
}

/// @nodoc
class _$CellDtoCopyWithImpl<$Res> implements $CellDtoCopyWith<$Res> {
  _$CellDtoCopyWithImpl(this._self, this._then);

  final CellDto _self;
  final $Res Function(CellDto) _then;

  /// Create a copy of CellDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? state = null,
  }) {
    return _then(_self.copyWith(
      index: null == index
          ? _self.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      state: null == state
          ? _self.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _CellDto extends CellDto {
  const _CellDto({required this.index, required this.state}) : super._();
  factory _CellDto.fromJson(Map<String, dynamic> json) =>
      _$CellDtoFromJson(json);

  @override
  final int index;
  @override
  final String state;

  /// Create a copy of CellDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CellDtoCopyWith<_CellDto> get copyWith =>
      __$CellDtoCopyWithImpl<_CellDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CellDtoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CellDto &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.state, state) || other.state == state));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, index, state);

  @override
  String toString() {
    return 'CellDto(index: $index, state: $state)';
  }
}

/// @nodoc
abstract mixin class _$CellDtoCopyWith<$Res> implements $CellDtoCopyWith<$Res> {
  factory _$CellDtoCopyWith(_CellDto value, $Res Function(_CellDto) _then) =
      __$CellDtoCopyWithImpl;
  @override
  @useResult
  $Res call({int index, String state});
}

/// @nodoc
class __$CellDtoCopyWithImpl<$Res> implements _$CellDtoCopyWith<$Res> {
  __$CellDtoCopyWithImpl(this._self, this._then);

  final _CellDto _self;
  final $Res Function(_CellDto) _then;

  /// Create a copy of CellDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? index = null,
    Object? state = null,
  }) {
    return _then(_CellDto(
      index: null == index
          ? _self.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      state: null == state
          ? _self.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
