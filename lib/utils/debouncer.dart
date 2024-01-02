import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  Timer? _timer;

  void run(Duration duration, VoidCallback action) {
    bool isActive = _timer?.isActive ?? false;

    if (isActive) {
      _timer?.cancel();
    }

    _timer = Timer(duration, action);
  }
}
