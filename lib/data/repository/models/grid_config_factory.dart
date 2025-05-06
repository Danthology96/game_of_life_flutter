import 'package:flutter/material.dart';
import 'package:game_of_life_exercise/data/repository/enums/grid_config_types.dart';
import 'package:game_of_life_exercise/data/repository/models/grid_config.dart';

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
          context.dimension!,
          context.aliveColor,
          context.deadColor,
        );
    }
  }
}

class GridConfigContext {
  final GridConfigTypes gridType;

  final int? dimension;
  final Color? aliveColor;
  final Color? deadColor;

  GridConfigContext._({
    required this.gridType,
    this.aliveColor,
    this.deadColor,
    this.dimension,
  });

  factory GridConfigContext.defaultConfig() =>
      GridConfigContext._(gridType: GridConfigTypes.MEDIUM);

  factory GridConfigContext.small({Color? aliveColor, Color? deadColor}) =>
      GridConfigContext._(
        gridType: GridConfigTypes.SMALL,
        aliveColor: aliveColor,
        deadColor: deadColor,
      );

  factory GridConfigContext.medium({Color? aliveColor, Color? deadColor}) =>
      GridConfigContext._(
        gridType: GridConfigTypes.MEDIUM,
        aliveColor: aliveColor,
        deadColor: deadColor,
      );

  factory GridConfigContext.large({Color? aliveColor, Color? deadColor}) =>
      GridConfigContext._(
        gridType: GridConfigTypes.LARGE,
        aliveColor: aliveColor,
        deadColor: deadColor,
      );

  factory GridConfigContext.extraLarge({Color? aliveColor, Color? deadColor}) =>
      GridConfigContext._(
        gridType: GridConfigTypes.EXTRA_LARGE,
        aliveColor: aliveColor,
        deadColor: deadColor,
      );

  factory GridConfigContext.custom({
    int? dimension,
    Color? aliveColor,
    required Color deadColor,
  }) => GridConfigContext._(
    gridType: GridConfigTypes.CUSTOM,
    aliveColor: aliveColor,
    deadColor: deadColor,
    dimension: dimension,
  );
}
