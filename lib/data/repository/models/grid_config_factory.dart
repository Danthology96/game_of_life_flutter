import 'package:flutter/material.dart';

import '../enums/game_of_life_enums.dart';
import 'grid_config.dart';

class GridConfigFactory {
  GridConfigFactory._(); // Private constructor to prevent instantiation

  static GridConfig createGridConfig(GridConfigContext context) {
    return switch (context.gridType) {
      GridConfigType.SMALL => SmallGridConfig(
        context.aliveColor,
        context.deadColor,
      ),
      GridConfigType.MEDIUM => MediumGridConfig(
        context.aliveColor,
        context.deadColor,
      ),
      GridConfigType.LARGE => LargeGridConfig(
        context.aliveColor,
        context.deadColor,
      ),
      GridConfigType.EXTRA_LARGE => ExtraLargeGridConfig(
        context.aliveColor,
        context.deadColor,
      ),
      GridConfigType.CUSTOM => CustomGridConfig(
        context.dimension!,
        context.aliveColor,
        context.deadColor,
      ),
    };
  }
}

class GridConfigContext {
  final GridConfigType gridType;

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
      GridConfigContext._(gridType: GridConfigType.MEDIUM);

  factory GridConfigContext.small({Color? aliveColor, Color? deadColor}) =>
      GridConfigContext._(
        gridType: GridConfigType.SMALL,
        aliveColor: aliveColor,
        deadColor: deadColor,
      );

  factory GridConfigContext.medium({Color? aliveColor, Color? deadColor}) =>
      GridConfigContext._(
        gridType: GridConfigType.MEDIUM,
        aliveColor: aliveColor,
        deadColor: deadColor,
      );

  factory GridConfigContext.large({Color? aliveColor, Color? deadColor}) =>
      GridConfigContext._(
        gridType: GridConfigType.LARGE,
        aliveColor: aliveColor,
        deadColor: deadColor,
      );

  factory GridConfigContext.extraLarge({Color? aliveColor, Color? deadColor}) =>
      GridConfigContext._(
        gridType: GridConfigType.EXTRA_LARGE,
        aliveColor: aliveColor,
        deadColor: deadColor,
      );

  factory GridConfigContext.custom({
    int? dimension,
    Color? aliveColor,
    required Color deadColor,
  }) => GridConfigContext._(
    gridType: GridConfigType.CUSTOM,
    aliveColor: aliveColor,
    deadColor: deadColor,
    dimension: dimension,
  );
}
