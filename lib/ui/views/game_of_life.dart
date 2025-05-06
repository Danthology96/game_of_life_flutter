import 'package:flutter/material.dart';
import 'package:game_of_life_exercise/data/repository/enums/cell_status.dart';
import 'package:game_of_life_exercise/data/repository/models/grid_config_factory.dart';
import 'package:game_of_life_exercise/view_model/game_logic.dart';

class GameOfLife extends StatefulWidget {
  const GameOfLife({super.key});

  @override
  GameOfLifeState createState() => GameOfLifeState();
}

class GameOfLifeState extends State<GameOfLife> {
  late GameLogic gameLogic;

  GridConfigContext gridConfigContext = GridConfigContext.custom(
    dimension: 10,
    aliveColor: Colors.deepOrange,
    deadColor: Colors.white,
  );
  @override
  void initState() {
    super.initState();
    gameLogic = GameLogic.fromConfig(
      GridConfigFactory.createGridConfig(gridConfigContext),
    );
  }

  void _tick() {
    setState(() {
      gameLogic.tick();
    });
  }

  @override
  Widget build(BuildContext context) {
    final int dimension = gameLogic.gridConfig.dimension;
    return Scaffold(
      appBar: AppBar(title: Text('Generation: ${gameLogic.generation}')),
      body: GridView.count(
        crossAxisCount: dimension,
        children: List.generate(dimension * dimension, (index) {
          int row = index ~/ dimension;
          int column = index % dimension;
          return Container(
            decoration: BoxDecoration(
              color:
                  gameLogic.grid[row][column] == CellStatus.ALIVE
                      ? gameLogic.gridConfig.aliveColor
                      : gameLogic.gridConfig.deadColor,
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
