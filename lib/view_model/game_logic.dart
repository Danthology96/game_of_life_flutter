import 'dart:math';

import 'package:game_of_life_exercise/data/repository/enums/cell_status.dart';
import 'package:game_of_life_exercise/data/repository/models/grid_config.dart';

import '../data/repository/models/grid_config_factory.dart';

class GameLogic {
  late int generation;
  GridConfig _gridConfig = GridConfigFactory.createGridConfig(
    GridConfigContext.defaultConfig(),
  );

  late List<List<CellStatus>> _grid;
  late int _rows;
  late int _columns;
  late Random genLife = Random();

  static final GameLogic _instance = GameLogic._internal();

  GridConfig get gridConfig => _gridConfig;

  List<List<CellStatus>> get grid => _grid;

  set setGridConfig(GridConfig config) {
    _gridConfig = config;
  }

  factory GameLogic() {
    return _instance;
  }

  GameLogic._internal() {
    _rows = 30;
    _columns = 30;
    generation = 0;
    initGrid();
  }
  GameLogic.fromConfig(this._gridConfig) {
    _rows = gridConfig.dimension;
    _columns = gridConfig.dimension;
    generation = 0;
    initGrid();
  }

  void initGrid() {
    _grid = List.generate(_rows, (_) => List.filled(_columns, CellStatus.DEAD));
    for (int i = 0; i < _rows; i++) {
      for (int j = 0; j < _columns; j++) {
        _grid[i][j] = genLife.nextBool() ? CellStatus.ALIVE : CellStatus.DEAD;
      }
    }
  }

  int _countAliveNeighbors(int row, int column) {
    int count = 0;
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        if (i == 0 && j == 0) continue;
        int r = row + i;
        int c = column + j;
        if (r >= 0 &&
            r < _rows &&
            c >= 0 &&
            c < _columns &&
            _grid[r][c] == CellStatus.ALIVE) {
          count++;
        }
      }
    }
    return count;
  }

  void tick() {
    generation++;
    List<List<CellStatus>> nextGrid = List.generate(
      _rows,
      (_) => List.filled(_columns, CellStatus.DEAD),
    );
    for (int i = 0; i < _rows; i++) {
      for (int j = 0; j < _columns; j++) {
        int neighbors = _countAliveNeighbors(i, j);
        if (_grid[i][j] == CellStatus.ALIVE) {
          if (neighbors == 2 || neighbors == 3) {
            nextGrid[i][j] = CellStatus.ALIVE;
          } else {
            nextGrid[i][j] = CellStatus.DEAD;
          }
        } else {
          if (neighbors == 3) {
            nextGrid[i][j] = CellStatus.ALIVE;
          } else {
            nextGrid[i][j] = CellStatus.DEAD;
          }
        }
      }
    }
    _grid = nextGrid;
  }
}
