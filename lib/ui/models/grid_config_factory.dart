import 'package:flutter/material.dart';
import 'package:game_of_life_exercise/ui/enums/grid_config_types.dart';
import 'package:game_of_life_exercise/ui/models/grid_config.dart';

class GridConfigFactory {
  GridConfigFactory._(); // Private constructor to prevent instantiation

  static GridConfig createGridConfig(GridConfigContext context) {
    switch (context.gridType) {
      case GridConfigTypes.SMALL:
        return SmallGridConfig(context.aliveColor, context.deadColor);
      case GridConfigTypes.MEDIUM:
        return MediumGridConfig(context.aliveColor, context.deadColor);
      case GridConfigTypes.LARGE:
        return LargeGridConfig(context.aliveColor, context.deadColor);
      case GridConfigTypes.EXTRA_LARGE:
        return ExtraLargeGridConfig(context.aliveColor, context.deadColor);
      case GridConfigTypes.CUSTOM:
        return CustomGridConfig(
          context.dimension,
          context.aliveColor,
          context.deadColor,
        );
    }
  }
}

class GridConfigContext {
  late int dimension;
  late Color aliveColor;
  late Color deadColor;
  late GridConfigTypes gridType;
}
