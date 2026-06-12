import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../novel_reader.dart';
import '../state/settings_provider.dart';
import '../state/reading_provider.dart';
import '../widgets/reading_area.dart';
import '../widgets/reader_app_bar.dart';
import '../widgets/reader_bottom_bar.dart';
import '../widgets/settings_panel.dart';

/// The main reading screen that orchestrates the UI and interactions.
class ReaderPage extends ConsumerStatefulWidget {
  /// Configuration for the novel being read.
  final ReaderConfig config;

  /// Callback when the user requests the next chapter.
  final VoidCallback? onNextChapter;

  /// Callback when the user requests the previous chapter.
  final VoidCallback? onPreviousChapter;

  /// Callback when the current chapter index changes.
  final Function(int)? onChapterChanged;

  /// Creates a [ReaderPage] instance.
  const ReaderPage({
    super.key,
    required this.config,
    this.onNextChapter,
    this.onPreviousChapter,
    this.onChapterChanged,
  });

  @override
  ConsumerState<ReaderPage> createState() => _ReaderPageState();
}

class _ReaderPageState extends ConsumerState<ReaderPage> {
  bool _showControls = false;
  late ScrollController _scrollController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(readingProvider.notifier).loadProgress();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  /// Handles single-tap events to toggle controls or navigate.
  void _handleTapAt(Offset position) {
    final width = MediaQuery.of(context).size.width;
    final x = position.dx;
    final settings = ref.read(settingsProvider);

    if (x > width * 0.3 && x < width * 0.7) {
      _toggleControls();
    } else if (settings.scrollMode == ScrollMode.horizontal) {
      if (_pageController.hasClients) {
        if (x <= width * 0.3) {
          _pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      }
    } else {
      if (_scrollController.hasClients) {
        if (x <= width * 0.3) {
          _scrollController.animateTo(
            (_scrollController.offset -
                    MediaQuery.of(context).size.height * 0.8)
                .clamp(0, _scrollController.position.maxScrollExtent),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else {
          _scrollController.animateTo(
            (_scrollController.offset +
                    MediaQuery.of(context).size.height * 0.8)
                .clamp(0, _scrollController.position.maxScrollExtent),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      }
    }
  }

  /// Toggles the visibility of the App Bar and Bottom Bar.
  void _toggleControls() {
    HapticFeedback.lightImpact();
    setState(() {
      _showControls = !_showControls;
    });
  }

  /// Navigates to the next chapter.
  void _handleNext() {
    final readingState = ref.read(readingProvider);
    if (readingState.currentChapterIndex < widget.config.chapters.length - 1) {
      ref
          .read(readingProvider.notifier)
          .updateChapter(readingState.currentChapterIndex + 1);
      widget.onNextChapter?.call();
    }
  }

  /// Navigates to the previous chapter.
  void _handlePrevious() {
    final readingState = ref.read(readingProvider);
    if (readingState.currentChapterIndex > 0) {
      ref
          .read(readingProvider.notifier)
          .updateChapter(readingState.currentChapterIndex - 1);
      widget.onPreviousChapter?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final readingState = ref.watch(readingProvider);
    final settings = ref.watch(settingsProvider);
    final theme = ReaderTheme.getTheme(settings.themeMode);

    ref.listen(readingProvider, (previous, next) {
      if (previous?.currentChapterIndex != next.currentChapterIndex) {
        widget.onChapterChanged?.call(next.currentChapterIndex);
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(0);
        }
      }
    });

    if (settings.hideStatusBar || !_showControls) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }

    final isFirstChapter = readingState.currentChapterIndex == 0;
    final isLastChapter =
        readingState.currentChapterIndex == widget.config.chapters.length - 1;

    Widget body = Column(
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child:
              _showControls
                  ? ReaderAppBar(
                    title: widget.config.title,
                    theme: theme,
                    onSettingsTap: () => _showSettings(context),
                    chapters: widget.config.chapters,
                  )
                  : const SizedBox.shrink(),
        ),
        Expanded(
          child: GestureDetector(
            key: const Key('reader_gesture_handler'),
            onTapUp: (details) => _handleTapAt(details.globalPosition),
            behavior: HitTestBehavior.translucent,
            child: ReadingArea(
              config: widget.config,
              settings: settings,
              theme: theme,
              controller: _scrollController,
              pageController: _pageController,
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child:
              _showControls
                  ? ReaderBottomBar(
                    theme: theme,
                    currentChapterIndex: readingState.currentChapterIndex,
                    totalChapters: widget.config.chapters.length,
                    onChapterChanged: (index) {
                      ref.read(readingProvider.notifier).updateChapter(index);
                    },
                    onPreviousChapter: isFirstChapter ? null : _handlePrevious,
                    onNextChapter: isLastChapter ? null : _handleNext,
                    scrollController: _scrollController,
                  )
                  : const SizedBox.shrink(),
        ),
      ],
    );

    final platform = Theme.of(context).platform;
    if (kIsWeb ||
        platform == TargetPlatform.windows ||
        platform == TargetPlatform.macOS ||
        platform == TargetPlatform.linux) {
      body = CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.arrowRight): () {
            if (settings.scrollMode == ScrollMode.horizontal) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            } else {
              _handleNext();
            }
          },
          const SingleActivator(LogicalKeyboardKey.arrowLeft): () {
            if (settings.scrollMode == ScrollMode.horizontal) {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            } else {
              _handlePrevious();
            }
          },
          const SingleActivator(LogicalKeyboardKey.pageDown): _handleNext,
          const SingleActivator(LogicalKeyboardKey.pageUp): _handlePrevious,
          const SingleActivator(LogicalKeyboardKey.space): _toggleControls,
          const SingleActivator(LogicalKeyboardKey.escape): () {
            if (_showControls) {
              _toggleControls();
            }
          },
          const SingleActivator(LogicalKeyboardKey.equal, control: true): () {
            ref
                .read(settingsProvider.notifier)
                .updateFontSize(settings.fontSize + 1);
          },
          const SingleActivator(LogicalKeyboardKey.minus, control: true): () {
            ref
                .read(settingsProvider.notifier)
                .updateFontSize(settings.fontSize - 1);
          },
        },
        child: Focus(autofocus: true, child: body),
      );
    }

    if (platform == TargetPlatform.android) {
      body = PopScope(
        canPop: !_showControls,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop && _showControls) {
            _toggleControls();
          }
        },
        child: body,
      );
    }

    return Scaffold(backgroundColor: theme.backgroundColor, body: body);
  }

  /// Shows the reading settings bottom sheet.
  void _showSettings(BuildContext context) {
    final container = ProviderScope.containerOf(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => UncontrolledProviderScope(
            container: container,
            child: const SettingsPanel(),
          ),
    );
  }
}
