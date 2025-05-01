import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_of_life_exercise/ui/enums/cell_status.dart';

class GameOfLife extends StatefulWidget {
  const GameOfLife({super.key});

  @override
  GameOfLifeState createState() => GameOfLifeState();
}

class GameOfLifeState extends State<GameOfLife> {
  late List<List<CellStatus>> _grid;
  late int _rows;
  late int _columns;
  late int _generation;
  late Random genLife = Random();

  @override
  void initState() {
    super.initState();
    _rows = 30;
    _columns = 30;
    _generation = 0;
    _initGrid();
  }

  void _initGrid() {
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

  void _tick() {
    setState(() {
      _generation++;
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Generation: $_generation')),
      body: GridView.count(
        crossAxisCount: _columns,
        children: List.generate(_rows * _columns, (index) {
          int row = index ~/ _columns;
          int column = index % _columns;
          return Container(
            decoration: BoxDecoration(
              color:
                  _grid[row][column] == CellStatus.ALIVE
                      ? Colors.black
                      : Colors.white,
              border: Border.all(color: Colors.grey),
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tick,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
