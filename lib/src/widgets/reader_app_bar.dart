import 'package:flutter/material.dart';
import '../theme/reader_theme.dart';
import '../models/chapter.dart';

/// The top navigation bar for the reader.
class ReaderAppBar extends StatelessWidget {
  /// The title of the book or current chapter.
  final String title;

  /// The current reader theme.
  final ReaderTheme theme;

  /// Callback when the settings icon is tapped.
  final VoidCallback onSettingsTap;

  /// The list of chapters in the novel.
  final List<Chapter> chapters;

  /// Creates a [ReaderAppBar] instance.
  const ReaderAppBar({
    super.key,
    required this.title,
    required this.theme,
    required this.onSettingsTap,
    required this.chapters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: Border(
          bottom: BorderSide(color: theme.textColor.withValues(alpha: 0.08), width: 0.5),
        ),
      ),
      child: AppBar(
        primary: false,
        title: Text(
          title,
          style: TextStyle(
            color: theme.textColor,
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
        backgroundColor: theme.backgroundColor,
        surfaceTintColor: theme.backgroundColor,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: theme.textColor, size: 18),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.tune_rounded, color: theme.textColor, size: 22),
            onPressed: onSettingsTap,
          ),
        ],
      ),
    );
  }
}
