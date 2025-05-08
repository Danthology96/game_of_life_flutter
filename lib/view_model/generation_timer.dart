import 'dart:async';

import 'package:game_of_life_exercise/view_model/game_controller.dart';
import 'package:game_of_life_exercise/view_model/observer.dart';

class GenerationTimer implements Subject, GameController {
  static final GenerationTimer _instance = GenerationTimer._internal();

  Timer? _timer;
  final List<Observer> _observers = [];

  bool get isActive => _timer != null && _timer!.isActive;

  factory GenerationTimer() {
    return _instance;
  }
  GenerationTimer._internal();

  @override
  void attachObserver(Observer observer) {
    if (!_observers.contains(observer)) {
      _observers.add(observer);
    }
  }

  @override
  void detachObserver(Observer observer) {
    _observers.remove(observer);
  }

  @override
  void notifyObservers() {
    for (var observer in _observers) {
      observer.update();
    }
  }

  @override
  void playGame() {
    if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
        notifyObservers();
      });
    }
  }

  @override
  void pauseGame() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
      _timer = null;
    }
  }

  @override
  void resetGame() {
    _timer?.cancel();
    _timer = null;
    notifyObservers();
  }

  @override
  void stopGame() {
    _timer?.cancel();
    _timer = null;
    notifyObservers();
  }
}
