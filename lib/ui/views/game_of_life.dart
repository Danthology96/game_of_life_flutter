import 'package:flutter/material.dart';
import 'package:game_of_life_exercise/data/repository/enums/game_of_life_enums.dart';
import 'package:game_of_life_exercise/data/repository/models/grid_config_factory.dart';
import 'package:game_of_life_exercise/view_model/game_logic.dart';
import 'package:game_of_life_exercise/view_model/generation_timer.dart';
import 'package:game_of_life_exercise/view_model/observer.dart';

class GameOfLife extends StatefulWidget {
  const GameOfLife({super.key});

  @override
  GameOfLifeState createState() => GameOfLifeState();
}

class GameOfLifeState extends State<GameOfLife> {
  late GameLogic gameLogic;
  late GenerationTimer _gameTimer;
  late TimerObserver _timerObserver;
  GameState _gameState = GameState.STOPPED;

  GridConfigContext gridConfigContext = GridConfigContext.custom(
    dimension: 10,
    aliveColor: Colors.deepOrange,
    deadColor: Colors.white,
  );
  @override
  void initState() {
    super.initState();
    _gameTimer = GenerationTimer();

    _timerObserver = TimerObserver(() => _gameState, _tick);

    _gameTimer.attachObserver(_timerObserver);

    gameLogic = GameLogic.fromConfig(
      GridConfigFactory.createGridConfig(gridConfigContext),
      _gameTimer,
    );
  }

  @override
  void dispose() {
    _gameTimer.detachObserver(_timerObserver);
    _gameTimer.stopGame();
    super.dispose();
  }

  void _tick() {
    setState(() {
      gameLogic.createNextGen();
    });
  }

  @override
  Widget build(BuildContext context) {
    final int dimension = gameLogic.gridConfig.dimension;
    return Scaffold(
      appBar: AppBar(title: Text('Generation: ${gameLogic.generation}')),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _gameState = GameState.STOPPED;
                    gameLogic.resetGame();
                  });
                },
                child: const Text('Reset'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _gameState = GameState.PLAYING;
                    gameLogic.playGame();
                  });
                },
                child: const Text('Play'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _gameState = GameState.PAUSED;
                    gameLogic.pauseGame();
                  });
                },
                child: const Text('Pause'),
              ),
              const SizedBox(width: 10),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _gameState = GameState.STOPPED;
                    gameLogic.stopGame();
                  });
                },
                child: const Text('Stop'),
              ),
            ],
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
