import 'package:flutter/material.dart';

import '../enums/game_of_life_enums.dart';

abstract class GridConfig {
  int _dimension = 0;
  Color _aliveColor = Colors.black;
  Color _deadColor = Colors.transparent;
  GridConfigType _gridType = GridConfigType.CUSTOM;

  int get dimension => _dimension;
  Color get aliveColor => _aliveColor;
  Color get deadColor => _deadColor;
  GridConfigType get gridType => _gridType;

  @protected
  set setGridType(GridConfigType type) {
    _gridType = type;
  }

  void setConfig(int dimension, Color? aliveColor, Color? deadColor) {
    _dimension = dimension;
    _aliveColor = aliveColor ?? _aliveColor;
    _deadColor = deadColor ?? _deadColor;
  }
}

class SmallGridConfig extends GridConfig {
  SmallGridConfig(Color? aliveColor, Color? deadColor) {
    setConfig(20, aliveColor, deadColor);
    setGridType = GridConfigType.SMALL;
  }
}

class MediumGridConfig extends GridConfig {
  MediumGridConfig(Color? aliveColor, Color? deadColor) {
    setConfig(30, aliveColor, deadColor);
    setGridType = GridConfigType.MEDIUM;
  }
}

class LargeGridConfig extends GridConfig {
  LargeGridConfig(Color? aliveColor, Color? deadColor) {
    setConfig(40, aliveColor, deadColor);
    setGridType = GridConfigType.LARGE;
  }
}

class ExtraLargeGridConfig extends GridConfig {
  ExtraLargeGridConfig(Color? aliveColor, Color? deadColor) {
    setConfig(50, aliveColor, deadColor);
    setGridType = GridConfigType.EXTRA_LARGE;
  }
}

class CustomGridConfig extends GridConfig {
  CustomGridConfig(int dimension, Color? aliveColor, Color? deadColor) {
    setConfig(dimension, aliveColor, deadColor);
    setGridType = GridConfigType.CUSTOM;
  }
}
