import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final autoScrollProvider = StateNotifierProvider<AutoScrollNotifier, bool>((ref) {
  return AutoScrollNotifier();
});

class AutoScrollNotifier extends StateNotifier<bool> {
  Timer? _timer;
  double _speed = 1.0; // pixels per frame or similar

  AutoScrollNotifier() : super(false);

  void toggle(ScrollController controller) {
    if (state) {
      stop();
    } else {
      start(controller);
    }
  }

  void start(ScrollController controller) {
    state = true;
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (controller.hasClients) {
        if (controller.offset >= controller.position.maxScrollExtent) {
          stop();
        } else {
          controller.jumpTo(controller.offset + _speed);
        }
      }
    });
  }

  void stop() {
    state = false;
    _timer?.cancel();
  }

  void setSpeed(double speed) {
    _speed = speed;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
