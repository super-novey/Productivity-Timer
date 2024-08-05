import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import './timermodel.dart';

class CountDownTimer {
  double _radius = 1; // express the percentage of completed time
  bool _isActive = true; // true if the counter is active
  //late TimerModel timer; // 
  late Duration _time;
  late Duration _fullTime;
  int work = 30;
  int shortBreak = 5;
  int longBreak = 20;

  String returnTime(Duration t) {
    String minutes =
        (t.inMinutes < 10) ? '0${t.inMinutes}' : t.inMinutes.toString();
    int numSeconds = t.inSeconds - (t.inMinutes * 60);
    String seconds =
        (numSeconds < 10) ? '0${numSeconds.toString()}' : numSeconds.toString();
    String formattedTime = "$minutes:$seconds";
    return formattedTime;
  }

  Stream<TimerModel> stream() async* {
    yield* Stream.periodic(const Duration(seconds: 1), (int a) {
      String time;
      if (_isActive) {
        _time = _time - const Duration(seconds: 1);
        _radius = _time.inSeconds / _fullTime.inSeconds;
        if (_time.inSeconds <= 0) {
          _isActive = false;
        }
      }
      time = returnTime(_time);
      return TimerModel(time, _radius);
    });
  }

  void startWork() async {
    await readSettings();
    _radius = 1;
    _time = Duration(minutes: work, seconds: 0);
    _fullTime = _time;
  }

  void stopTimer() {
    _isActive = false;
  }

  void startTimer() {
    if (_time.inSeconds > 0) {
      _isActive = true;
    }
  }

  void startBreak(bool isShort) async {
    await readSettings(); 
    _radius = 1;
    _time = Duration(minutes: (isShort) ? shortBreak : longBreak, seconds: 0);
    _fullTime = _time;
  }

  Future readSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    work = prefs.getInt('workTime') ?? work;
    shortBreak = prefs.getInt('shortBreak') ?? shortBreak;
    longBreak = prefs.getInt('longBreak') ?? longBreak;
  }
}
