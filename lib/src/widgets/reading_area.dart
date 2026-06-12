import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/chapter.dart';
import '../models/reader_config.dart';
import '../models/reading_settings.dart';
import '../theme/reader_theme.dart';
import '../core/utils/pagination_helper.dart';
import '../state/reading_provider.dart';

/// The widget responsible for rendering the actual reading content.
///
/// Supports both vertical scrolling and horizontal paging modes.
class ReadingArea extends ConsumerWidget {
  /// Configuration for the novel.
  final ReaderConfig config;

  /// The current reading settings.
  final ReadingSettings settings;

  /// The current reader theme.
  final ReaderTheme theme;

  /// Controller for vertical scrolling.
  final ScrollController controller;

  /// Controller for horizontal paging.
  final PageController pageController;

  /// Creates a [ReadingArea] instance.
  const ReadingArea({
    super.key,
    required this.config,
    required this.settings,
    required this.theme,
    required this.controller,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readingState = ref.watch(readingProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        if (settings.scrollMode == ScrollMode.horizontal) {
          return _buildHorizontalPagedView(
            context,
            constraints,
            readingState.currentChapterIndex,
          );
        }
        return _buildVerticalScrollView(
          context,
          readingState.currentChapterIndex,
        );
      },
    );
  }

  /// Builds a vertically scrollable view for a single chapter.
  Widget _buildVerticalScrollView(
    BuildContext context,
    int currentChapterIndex,
  ) {
    final chapter = config.chapters[currentChapterIndex];
    final platform = Theme.of(context).platform;
    final platformPhysics =
        (platform == TargetPlatform.iOS || platform == TargetPlatform.macOS)
            ? const BouncingScrollPhysics()
            : const ClampingScrollPhysics();

    return SingleChildScrollView(
      controller: controller,
      physics: platformPhysics,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 32),
          child: _buildChapterContent(chapter),
        ),
      ),
    );
  }

  /// Builds a horizontally paged view for a single chapter.
  Widget _buildHorizontalPagedView(
    BuildContext context,
    BoxConstraints constraints,
    int currentChapterIndex,
  ) {
    final chapterPages = <Map<String, dynamic>>[];
    final textStyle = _getFont(settings.fontFamily).copyWith(
      fontSize: settings.fontSize,
      height: settings.lineHeight,
      letterSpacing: settings.letterSpacing,
      wordSpacing: settings.wordSpacing,
      color: theme.textColor,
    );

    final chapter = config.chapters[currentChapterIndex];
    final pages = PaginationHelper.paginate(
      chapter.content,
      textStyle,
      constraints.maxWidth - 48,
      constraints.maxHeight -
          MediaQuery.of(context).padding.top -
          MediaQuery.of(context).padding.bottom -
          120,
      settings.textAlign,
    );

    for (var pageContent in pages) {
      chapterPages.add({'content': pageContent, 'chapterTitle': chapter.title});
    }

    return PageView.builder(
      key: ValueKey('chapter_$currentChapterIndex'),
      controller: pageController,
      physics: const BouncingScrollPhysics(),
      itemCount: chapterPages.length,
      itemBuilder: (context, index) {
        final page = chapterPages[index];
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 20,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        page['chapterTitle'],
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: theme.textColor.withValues(alpha: 0.3),
                          letterSpacing: 1.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    style: textStyle,
                    textAlign: settings.textAlign,
                    child: Text(page['content']),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: theme.textColor.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${index + 1} / ${chapterPages.length}',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: theme.textColor.withValues(alpha: 0.4),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Renders the chapter title and body text.
  Widget _buildChapterContent(Chapter chapter) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chapter.title,
                style: TextStyle(
                  fontSize: settings.fontSize,
                  fontWeight: FontWeight.w900,
                  color: theme.textColor,
                  height: 1.2,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          style: _getFont(settings.fontFamily).copyWith(
            fontSize: settings.fontSize,
            height: settings.lineHeight,
            letterSpacing: settings.letterSpacing,
            wordSpacing: settings.wordSpacing,
            color: theme.textColor,
          ),
          textAlign: settings.textAlign,
          child: Text(chapter.content),
        ),
      ],
    );
  }

  /// Helper to map font family names to actual [TextStyle]s.
  TextStyle _getFont(String fontFamily) {
    switch (fontFamily) {
      case 'Serif':
        return GoogleFonts.merriweather();
      case 'Sans Serif':
        return GoogleFonts.openSans();
      case 'Roboto':
        return GoogleFonts.roboto();
      case 'Georgia':
        return const TextStyle(fontFamily: 'Georgia');
      default:
        return const TextStyle();
    }
  }
}
