import 'package:flutter/material.dart';
import 'package:game_of_life_exercise/ui/enums/grid_config_types.dart';

abstract class GridConfig {
  int _dimension = 0;
  Color _aliveColor = Colors.black;
  Color _deadColor = Colors.transparent;
  GridConfigTypes _gridType = GridConfigTypes.CUSTOM;

  int get dimension => _dimension;
  Color get aliveColor => _aliveColor;
  Color get deadColor => _deadColor;
  GridConfigTypes get gridType => _gridType;

  @protected
  set setGridType(GridConfigTypes type) {
    _gridType = type;
  }

  void setConfig(int dimension, Color aliveColor, Color deadColor) {
    _dimension = dimension;
    _aliveColor = aliveColor;
    _deadColor = deadColor;
  }
}

class SmallGridConfig extends GridConfig {
  SmallGridConfig(Color aliveColor, Color deadColor) {
    setConfig(20, aliveColor, deadColor);
    setGridType = GridConfigTypes.SMALL;
  }
}

class MediumGridConfig extends GridConfig {
  MediumGridConfig(Color aliveColor, Color deadColor) {
    setConfig(30, aliveColor, deadColor);
    setGridType = GridConfigTypes.MEDIUM;
  }
}

class LargeGridConfig extends GridConfig {
  LargeGridConfig(Color aliveColor, Color deadColor) {
    setConfig(40, aliveColor, deadColor);
    setGridType = GridConfigTypes.LARGE;
  }
}

class ExtraLargeGridConfig extends GridConfig {
  ExtraLargeGridConfig(Color aliveColor, Color deadColor) {
    setConfig(50, aliveColor, deadColor);
    setGridType = GridConfigTypes.EXTRA_LARGE;
  }
}

class CustomGridConfig extends GridConfig {
  CustomGridConfig(int dimension, Color aliveColor, Color deadColor) {
    setConfig(dimension, aliveColor, deadColor);
    setGridType = GridConfigTypes.CUSTOM;
  }
}
