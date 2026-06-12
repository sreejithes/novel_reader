import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider for the [ReadingState].
final readingProvider = StateNotifierProvider<ReadingNotifier, ReadingState>((
  ref,
) {
  return ReadingNotifier();
});

/// Represents the current reading progress in a book.
class ReadingState {
  /// The index of the chapter currently being read.
  final int currentChapterIndex;

  /// The vertical scroll position within the current chapter.
  final double scrollPosition;

  /// Creates a [ReadingState] instance.
  ReadingState({this.currentChapterIndex = 0, this.scrollPosition = 0.0});

  /// Creates a copy of this state with updated values.
  ReadingState copyWith({int? currentChapterIndex, double? scrollPosition}) {
    return ReadingState(
      currentChapterIndex: currentChapterIndex ?? this.currentChapterIndex,
      scrollPosition: scrollPosition ?? this.scrollPosition,
    );
  }
}

/// Notifier that manages and persists reading progress.
class ReadingNotifier extends StateNotifier<ReadingState> {
  /// Creates a [ReadingNotifier].
  ReadingNotifier() : super(ReadingState());

  /// Updates the current chapter and resets scroll position.
  void updateChapter(int index) {
    state = state.copyWith(currentChapterIndex: index, scrollPosition: 0.0);
    _saveProgress();
  }

  /// Updates the scroll position within the current chapter.
  void updateScrollPosition(double position) {
    state = state.copyWith(scrollPosition: position);
    _saveProgress();
  }

  /// Persists current reading progress to [SharedPreferences].
  Future<void> _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('last_chapter', state.currentChapterIndex);
    await prefs.setDouble('last_scroll', state.scrollPosition);
  }

  /// Loads reading progress from [SharedPreferences].
  Future<void> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    state = ReadingState(
      currentChapterIndex: prefs.getInt('last_chapter') ?? 0,
      scrollPosition: prefs.getDouble('last_scroll') ?? 0.0,
    );
  }
}
