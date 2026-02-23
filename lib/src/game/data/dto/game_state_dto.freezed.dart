// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GameStateDto {

 String get id; int get date; List<CellDto> get cells; String get status;
/// Create a copy of GameStateDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameStateDtoCopyWith<GameStateDto> get copyWith => _$GameStateDtoCopyWithImpl<GameStateDto>(this as GameStateDto, _$identity);

  /// Serializes this GameStateDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameStateDto&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.cells, cells)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,const DeepCollectionEquality().hash(cells),status);

@override
String toString() {
  return 'GameStateDto(id: $id, date: $date, cells: $cells, status: $status)';
}


}

/// @nodoc
abstract mixin class $GameStateDtoCopyWith<$Res>  {
  factory $GameStateDtoCopyWith(GameStateDto value, $Res Function(GameStateDto) _then) = _$GameStateDtoCopyWithImpl;
@useResult
$Res call({
 String id, int date, List<CellDto> cells, String status
});




}
/// @nodoc
class _$GameStateDtoCopyWithImpl<$Res>
    implements $GameStateDtoCopyWith<$Res> {
  _$GameStateDtoCopyWithImpl(this._self, this._then);

  final GameStateDto _self;
  final $Res Function(GameStateDto) _then;

/// Create a copy of GameStateDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? cells = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as int,cells: null == cells ? _self.cells : cells // ignore: cast_nullable_to_non_nullable
as List<CellDto>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GameStateDto].
extension GameStateDtoPatterns on GameStateDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameStateDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameStateDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameStateDto value)  $default,){
final _that = this;
switch (_that) {
case _GameStateDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameStateDto value)?  $default,){
final _that = this;
switch (_that) {
case _GameStateDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int date,  List<CellDto> cells,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameStateDto() when $default != null:
return $default(_that.id,_that.date,_that.cells,_that.status);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int date,  List<CellDto> cells,  String status)  $default,) {final _that = this;
switch (_that) {
case _GameStateDto():
return $default(_that.id,_that.date,_that.cells,_that.status);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int date,  List<CellDto> cells,  String status)?  $default,) {final _that = this;
switch (_that) {
case _GameStateDto() when $default != null:
return $default(_that.id,_that.date,_that.cells,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameStateDto extends GameStateDto {
  const _GameStateDto({required this.id, required this.date, required final  List<CellDto> cells, required this.status}): _cells = cells,super._();
  factory _GameStateDto.fromJson(Map<String, dynamic> json) => _$GameStateDtoFromJson(json);

@override final  String id;
@override final  int date;
 final  List<CellDto> _cells;
@override List<CellDto> get cells {
  if (_cells is EqualUnmodifiableListView) return _cells;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cells);
}

@override final  String status;

/// Create a copy of GameStateDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameStateDtoCopyWith<_GameStateDto> get copyWith => __$GameStateDtoCopyWithImpl<_GameStateDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameStateDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameStateDto&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._cells, _cells)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,date,const DeepCollectionEquality().hash(_cells),status);

@override
String toString() {
  return 'GameStateDto(id: $id, date: $date, cells: $cells, status: $status)';
}


}

/// @nodoc
abstract mixin class _$GameStateDtoCopyWith<$Res> implements $GameStateDtoCopyWith<$Res> {
  factory _$GameStateDtoCopyWith(_GameStateDto value, $Res Function(_GameStateDto) _then) = __$GameStateDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, int date, List<CellDto> cells, String status
});




}
/// @nodoc
class __$GameStateDtoCopyWithImpl<$Res>
    implements _$GameStateDtoCopyWith<$Res> {
  __$GameStateDtoCopyWithImpl(this._self, this._then);

  final _GameStateDto _self;
  final $Res Function(_GameStateDto) _then;

/// Create a copy of GameStateDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? cells = null,Object? status = null,}) {
  return _then(_GameStateDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as int,cells: null == cells ? _self._cells : cells // ignore: cast_nullable_to_non_nullable
as List<CellDto>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
