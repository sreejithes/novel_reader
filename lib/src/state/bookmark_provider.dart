import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/bookmark.dart';

/// Provider for the list of user [Bookmark]s.
final bookmarkProvider =
    StateNotifierProvider<BookmarkNotifier, List<Bookmark>>((ref) {
  return BookmarkNotifier();
});

/// Notifier that manages and persists user bookmarks.
class BookmarkNotifier extends StateNotifier<List<Bookmark>> {
  /// Creates a [BookmarkNotifier] and loads existing bookmarks.
  BookmarkNotifier() : super([]) {
    _loadBookmarks();
  }

  /// Loads bookmarks from [SharedPreferences].
  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? bookmarksJson = prefs.getString('bookmarks');
    if (bookmarksJson != null) {
      final List<dynamic> decoded = jsonDecode(bookmarksJson);
      state = decoded.map((e) => Bookmark.fromJson(e)).toList();
    }
  }

  /// Adds a new [bookmark] and persists the list.
  Future<void> addBookmark(Bookmark bookmark) async {
    state = [...state, bookmark];
    await _saveBookmarks();
  }

  /// Removes a bookmark by its [id] and persists the list.
  Future<void> removeBookmark(String id) async {
    state = state.where((b) => b.id != id).toList();
    await _saveBookmarks();
  }

  /// Persists the list of bookmarks to [SharedPreferences].
  Future<void> _saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(state.map((e) => e.toJson()).toList());
    await prefs.setString('bookmarks', encoded);
  }
}
