import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_state.freezed.dart';

@freezed
class GameState with _$GameState {
  factory GameState({
    @Default(0) double dx,
    @Default(0) double dy,
    @Default(0) double ballDiameter,
    List<List<int>>? mazeDate,
    @Default(0) double cellWidth,
    @Default(0) double cellHeight,
    @Default(false) bool hasCollided,
    @Default(Size.zero) Size screenSize,
  }) = _GameState;
}
