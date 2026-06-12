import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for the auto-scroll state (active or inactive).
final autoScrollProvider = StateNotifierProvider<AutoScrollNotifier, bool>((
  ref,
) {
  return AutoScrollNotifier();
});

/// Notifier that manages the automatic scrolling logic for vertical mode.
class AutoScrollNotifier extends StateNotifier<bool> {
  Timer? _timer;
  double _speed = 1.0; // pixels per step

  /// Creates an [AutoScrollNotifier] initialized to inactive.
  AutoScrollNotifier() : super(false);

  /// Toggles the auto-scroll state.
  void toggle(ScrollController controller) {
    if (state) {
      stop();
    } else {
      start(controller);
    }
  }

  /// Starts the auto-scroll timer.
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

  /// Stops the auto-scroll timer.
  void stop() {
    state = false;
    _timer?.cancel();
  }

  /// Sets the speed of the automatic scroll.
  void setSpeed(double speed) {
    _speed = speed;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
