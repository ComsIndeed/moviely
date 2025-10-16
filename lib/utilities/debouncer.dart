import 'dart:async';
import 'package:flutter/foundation.dart';

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer(this.delay);

  void run(VoidCallback action) {
    // 1. Cancel the previous timer if it exists.
    _timer?.cancel();

    // 2. Start a new timer.
    // The action will only run if this timer expires without being cancelled.
    _timer = Timer(delay, action);
  }

  void dispose() {
    _timer?.cancel();
  }
}
