// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GameState {
  double get dx => throw _privateConstructorUsedError;
  double get dy => throw _privateConstructorUsedError;
  double get ballDiameter => throw _privateConstructorUsedError;
  List<List<int>>? get mazeDate => throw _privateConstructorUsedError;
  double get cellWidth => throw _privateConstructorUsedError;
  double get cellHeight => throw _privateConstructorUsedError;
  bool get hasCollided => throw _privateConstructorUsedError;
  Size get screenSize => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
  @useResult
  $Res call(
      {double dx,
      double dy,
      double ballDiameter,
      List<List<int>>? mazeDate,
      double cellWidth,
      double cellHeight,
      bool hasCollided,
      Size screenSize});
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res, $Val extends GameState>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dx = null,
    Object? dy = null,
    Object? ballDiameter = null,
    Object? mazeDate = freezed,
    Object? cellWidth = null,
    Object? cellHeight = null,
    Object? hasCollided = null,
    Object? screenSize = null,
  }) {
    return _then(_value.copyWith(
      dx: null == dx
          ? _value.dx
          : dx // ignore: cast_nullable_to_non_nullable
              as double,
      dy: null == dy
          ? _value.dy
          : dy // ignore: cast_nullable_to_non_nullable
              as double,
      ballDiameter: null == ballDiameter
          ? _value.ballDiameter
          : ballDiameter // ignore: cast_nullable_to_non_nullable
              as double,
      mazeDate: freezed == mazeDate
          ? _value.mazeDate
          : mazeDate // ignore: cast_nullable_to_non_nullable
              as List<List<int>>?,
      cellWidth: null == cellWidth
          ? _value.cellWidth
          : cellWidth // ignore: cast_nullable_to_non_nullable
              as double,
      cellHeight: null == cellHeight
          ? _value.cellHeight
          : cellHeight // ignore: cast_nullable_to_non_nullable
              as double,
      hasCollided: null == hasCollided
          ? _value.hasCollided
          : hasCollided // ignore: cast_nullable_to_non_nullable
              as bool,
      screenSize: null == screenSize
          ? _value.screenSize
          : screenSize // ignore: cast_nullable_to_non_nullable
              as Size,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameStateImplCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$$GameStateImplCopyWith(
          _$GameStateImpl value, $Res Function(_$GameStateImpl) then) =
      __$$GameStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double dx,
      double dy,
      double ballDiameter,
      List<List<int>>? mazeDate,
      double cellWidth,
      double cellHeight,
      bool hasCollided,
      Size screenSize});
}

/// @nodoc
class __$$GameStateImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameStateImpl>
    implements _$$GameStateImplCopyWith<$Res> {
  __$$GameStateImplCopyWithImpl(
      _$GameStateImpl _value, $Res Function(_$GameStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dx = null,
    Object? dy = null,
    Object? ballDiameter = null,
    Object? mazeDate = freezed,
    Object? cellWidth = null,
    Object? cellHeight = null,
    Object? hasCollided = null,
    Object? screenSize = null,
  }) {
    return _then(_$GameStateImpl(
      dx: null == dx
          ? _value.dx
          : dx // ignore: cast_nullable_to_non_nullable
              as double,
      dy: null == dy
          ? _value.dy
          : dy // ignore: cast_nullable_to_non_nullable
              as double,
      ballDiameter: null == ballDiameter
          ? _value.ballDiameter
          : ballDiameter // ignore: cast_nullable_to_non_nullable
              as double,
      mazeDate: freezed == mazeDate
          ? _value._mazeDate
          : mazeDate // ignore: cast_nullable_to_non_nullable
              as List<List<int>>?,
      cellWidth: null == cellWidth
          ? _value.cellWidth
          : cellWidth // ignore: cast_nullable_to_non_nullable
              as double,
      cellHeight: null == cellHeight
          ? _value.cellHeight
          : cellHeight // ignore: cast_nullable_to_non_nullable
              as double,
      hasCollided: null == hasCollided
          ? _value.hasCollided
          : hasCollided // ignore: cast_nullable_to_non_nullable
              as bool,
      screenSize: null == screenSize
          ? _value.screenSize
          : screenSize // ignore: cast_nullable_to_non_nullable
              as Size,
    ));
  }
}

/// @nodoc

class _$GameStateImpl implements _GameState {
  _$GameStateImpl(
      {this.dx = 0,
      this.dy = 0,
      this.ballDiameter = 0,
      final List<List<int>>? mazeDate,
      this.cellWidth = 0,
      this.cellHeight = 0,
      this.hasCollided = false,
      this.screenSize = Size.zero})
      : _mazeDate = mazeDate;

  @override
  @JsonKey()
  final double dx;
  @override
  @JsonKey()
  final double dy;
  @override
  @JsonKey()
  final double ballDiameter;
  final List<List<int>>? _mazeDate;
  @override
  List<List<int>>? get mazeDate {
    final value = _mazeDate;
    if (value == null) return null;
    if (_mazeDate is EqualUnmodifiableListView) return _mazeDate;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final double cellWidth;
  @override
  @JsonKey()
  final double cellHeight;
  @override
  @JsonKey()
  final bool hasCollided;
  @override
  @JsonKey()
  final Size screenSize;

  @override
  String toString() {
    return 'GameState(dx: $dx, dy: $dy, ballDiameter: $ballDiameter, mazeDate: $mazeDate, cellWidth: $cellWidth, cellHeight: $cellHeight, hasCollided: $hasCollided, screenSize: $screenSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStateImpl &&
            (identical(other.dx, dx) || other.dx == dx) &&
            (identical(other.dy, dy) || other.dy == dy) &&
            (identical(other.ballDiameter, ballDiameter) ||
                other.ballDiameter == ballDiameter) &&
            const DeepCollectionEquality().equals(other._mazeDate, _mazeDate) &&
            (identical(other.cellWidth, cellWidth) ||
                other.cellWidth == cellWidth) &&
            (identical(other.cellHeight, cellHeight) ||
                other.cellHeight == cellHeight) &&
            (identical(other.hasCollided, hasCollided) ||
                other.hasCollided == hasCollided) &&
            (identical(other.screenSize, screenSize) ||
                other.screenSize == screenSize));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      dx,
      dy,
      ballDiameter,
      const DeepCollectionEquality().hash(_mazeDate),
      cellWidth,
      cellHeight,
      hasCollided,
      screenSize);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      __$$GameStateImplCopyWithImpl<_$GameStateImpl>(this, _$identity);
}

abstract class _GameState implements GameState {
  factory _GameState(
      {final double dx,
      final double dy,
      final double ballDiameter,
      final List<List<int>>? mazeDate,
      final double cellWidth,
      final double cellHeight,
      final bool hasCollided,
      final Size screenSize}) = _$GameStateImpl;

  @override
  double get dx;
  @override
  double get dy;
  @override
  double get ballDiameter;
  @override
  List<List<int>>? get mazeDate;
  @override
  double get cellWidth;
  @override
  double get cellHeight;
  @override
  bool get hasCollided;
  @override
  Size get screenSize;
  @override
  @JsonKey(ignore: true)
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
