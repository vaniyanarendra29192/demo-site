import 'dart:async';

import 'package:flutter/foundation.dart';

class BMCTimerChangeNotifier extends ChangeNotifier {
  static final BMCTimerChangeNotifier _instance =
      BMCTimerChangeNotifier._internal();

  factory BMCTimerChangeNotifier() {
    return _instance;
  }

  BMCTimerChangeNotifier._internal();

  Timer? _timer;

  int _remainingTime = 0;

  Function()? _onComplete;

  int get remainingTime => _remainingTime;

  String get formatedRemainingSeconds => _formatSeconds(_remainingTime);

  bool get isRunning => _timer?.isActive ?? false;

  startTimer(int seconds, {Function()? onComplete}) {
    _remainingTime = seconds;
    if (onComplete != null) {
      _onComplete = onComplete;
    }
    _timer?.cancel();
    resumeTimer();
  }

  resumeTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateRemainingTime();
      if (_remainingTime == 0) {
        timer.cancel();
        _onComplete?.call();
      }
    });
  }

  toggleTimer() {
    if (_timer?.isActive == true) {
      stopTimer();
    } else {
      resumeTimer();
    }
  }

  updateRemainingTime() {
    if (_remainingTime > 0) {
      _remainingTime--;
    }
    notifyListeners();
  }

  stopTimer() {
    _timer?.cancel();
  }

  String _formatSeconds(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }
}
