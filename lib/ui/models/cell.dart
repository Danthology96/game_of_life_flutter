import 'package:flutter/material.dart';
import 'package:game_of_life_exercise/ui/enums/cell_status.dart';

abstract class Cell {
  int posX = 0;
  int posY = 0;
  CellStatus status = CellStatus.DEAD;
  Color? deadColor = Colors.transparent;
  Color? aliveColor = Colors.black;

  int get getPosX => posX;
  int get getPosY => posY;
  bool get isAlive => status == CellStatus.ALIVE;
  Color? get getColor => isAlive ? aliveColor : deadColor;
}

class ClassicCell extends Cell {
  ClassicCell({
    required posX,
    required posY,
    required status,
    Color? aliveColor,
    Color? deadColor,
  });

  factory ClassicCell.createCell() => ClassicCell(
    posX: 0,
    posY: 0,
    status: CellStatus.DEAD,
    aliveColor: Colors.black,
    deadColor: Colors.transparent,
  );
}
