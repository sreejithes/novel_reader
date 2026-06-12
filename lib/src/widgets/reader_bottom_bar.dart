import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/reader_theme.dart';
import '../localization/reader_localizations.dart';

/// The bottom navigation bar for the reader.
///
/// Includes chapter navigation buttons and an overall progress slider.
class ReaderBottomBar extends ConsumerWidget {
  /// The current reader theme.
  final ReaderTheme theme;

  /// Callback for the previous chapter button.
  final VoidCallback? onPreviousChapter;

  /// Callback for the next chapter button.
  final VoidCallback? onNextChapter;

  /// The controller managing the scrollable area.
  final ScrollController scrollController;

  /// The index of the chapter currently being viewed.
  final int currentChapterIndex;

  /// The total number of chapters in the book.
  final int totalChapters;

  /// Callback triggered when the user drags the progress slider.
  final ValueChanged<int>? onChapterChanged;

  /// Creates a [ReaderBottomBar] instance.
  const ReaderBottomBar({
    super.key,
    required this.theme,
    this.onPreviousChapter,
    this.onNextChapter,
    required this.scrollController,
    required this.currentChapterIndex,
    required this.totalChapters,
    this.onChapterChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ReaderLocalizations.of(context);
    final progress =
        totalChapters > 1 ? currentChapterIndex / (totalChapters - 1) : 1.0;

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + 8,
      ),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: Border(
          top: BorderSide(
            color: theme.textColor.withValues(alpha: 0.08),
            width: 0.5,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: SliderTheme(
                    data: SliderThemeData(
                      activeTrackColor: theme.accentColor,
                      inactiveTrackColor: theme.accentColor.withValues(
                        alpha: 0.1,
                      ),
                      thumbColor: theme.accentColor,
                      trackHeight: 2,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 5,
                      ),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 12,
                      ),
                    ),
                    child: Slider(
                      value: progress.clamp(0.0, 1.0),
                      divisions: totalChapters > 1 ? totalChapters - 1 : null,
                      onChanged: (val) {
                        if (onChapterChanged != null && totalChapters > 1) {
                          final index = (val * (totalChapters - 1)).round();
                          onChapterChanged!(index);
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: TextStyle(
                    color: theme.textColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavButton(
                  onPressed: onPreviousChapter,
                  icon: Icons.keyboard_arrow_left_rounded,
                  label: l10n.previous,
                  theme: theme,
                ),
                _buildNavButton(
                  onPressed: onNextChapter,
                  icon: Icons.keyboard_arrow_right_rounded,
                  label: l10n.next,
                  theme: theme,
                  isForward: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a stylized navigation button.
  Widget _buildNavButton({
    required VoidCallback? onPressed,
    required IconData icon,
    required String label,
    required ReaderTheme theme,
    bool isForward = false,
  }) {
    final isEnabled = onPressed != null;
    final color =
        isEnabled ? theme.textColor : theme.textColor.withValues(alpha: 0.2);

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            if (!isForward) Icon(icon, color: color, size: 20),
            if (!isForward) const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: isEnabled ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            if (isForward) const SizedBox(width: 8),
            if (isForward) Icon(icon, color: color, size: 20),
          ],
        ),
      ),
    );
  }
}
