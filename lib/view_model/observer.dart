import 'package:game_of_life_exercise/data/repository/enums/game_of_life_enums.dart';

abstract class Observer {
  void update();
}

abstract class Subject {
  void attachObserver(Observer observer);
  void detachObserver(Observer observer);
  void notifyObservers();
}

class TimerObserver extends Observer {
  final GameState Function() _state;
  final Function _onStateChange;

  TimerObserver(this._state, this._onStateChange);

  @override
  void update() {
    if (_state() == GameState.PLAYING) {
      _onStateChange.call();
    }
  }
}
