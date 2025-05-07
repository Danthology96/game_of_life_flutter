import 'dart:math';

import 'package:game_of_life_exercise/data/repository/enums/game_of_life_enums.dart';
import 'package:game_of_life_exercise/data/repository/models/grid_config.dart';
import 'package:game_of_life_exercise/view_model/game_controller.dart';
import 'package:game_of_life_exercise/view_model/generation_timer.dart';

import '../data/repository/models/grid_config_factory.dart';

class GameLogic implements GameController {
  late int generation;
  GridConfig _gridConfig = GridConfigFactory.createGridConfig(
    GridConfigContext.defaultConfig(),
  );

  late List<List<CellStatus>> _grid;
  late int _rows;
  late int _columns;
  late Random genLife = Random();
  late GenerationTimer _timer;

  static final GameLogic _instance = GameLogic._internal();

  GameLogic._internal();

  GridConfig get gridConfig => _gridConfig;

  List<List<CellStatus>> get grid => _grid;

  set setGridConfig(GridConfig config) {
    _gridConfig = config;
  }

  set setGameTimer(GenerationTimer timer) {
    _timer = timer;
  }

  factory GameLogic(GenerationTimer timer) {
    _instance._timer = timer;
    return _instance;
  }

  GameLogic.fromConfig(this._gridConfig, GenerationTimer timer) {
    _timer = timer;
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

  void createNextGen() {
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

  @override
  void pauseGame() {
    _timer.pauseGame();
  }

  @override
  void playGame() {
    if (!_timer.isActive) {
      _timer.playGame();
    }
  }

  @override
  void resetGame() {
    _timer.resetGame();
    generation = 0;
    initGrid();
  }

  @override
  void stopGame() {
    _timer.stopGame();
    generation = 0;
    initGrid();
  }
}
