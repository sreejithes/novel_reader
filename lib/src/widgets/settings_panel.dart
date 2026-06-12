import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../novel_reader_platform_interface.dart';
import '../state/settings_provider.dart';
import '../models/reading_settings.dart';
import '../theme/reader_theme.dart';
import '../localization/reader_localizations.dart';

/// The bottom sheet panel containing all reading adjustments.
///
/// Allows users to change theme, font size, family, alignment,
/// navigation mode, and system settings like brightness.
class SettingsPanel extends ConsumerWidget {
  /// Creates a [SettingsPanel] instance.
  const SettingsPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);
    final theme = ReaderTheme.getTheme(settings.themeMode);
    final l10n = ReaderLocalizations.of(context);
    final platform = Theme.of(context).platform;
    final isMobile =
        platform == TargetPlatform.android || platform == TargetPlatform.iOS;

    return Container(
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 30,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 12,
            left: 24,
            right: 24,
            bottom: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag Handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: theme.textColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildThemeSection(settings, notifier, theme, l10n),
                      const SizedBox(height: 32),
                      _buildFontSizeSection(settings, notifier, theme, l10n),
                      const SizedBox(height: 32),
                      _buildFontFamilySection(settings, notifier, theme, l10n),
                      const SizedBox(height: 32),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildTextAlignSection(
                              settings,
                              notifier,
                              theme,
                              l10n,
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: _buildScrollModeSection(
                              settings,
                              notifier,
                              theme,
                              l10n,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      _buildSpacingSection(settings, notifier, theme, l10n),
                      if (isMobile) ...[
                        const SizedBox(height: 24),
                        Divider(color: theme.textColor.withValues(alpha: 0.05)),
                        const SizedBox(height: 16),
                        _buildSystemSection(settings, notifier, theme, l10n),
                      ],
                      const SizedBox(height: 16),
                      _buildAboutSection(theme),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Displays basic app information and the native platform version.
  Widget _buildAboutSection(ReaderTheme theme) {
    return FutureBuilder<String?>(
      future: NovelReaderPlatform.instance.getPlatformVersion(),
      builder: (context, snapshot) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Novel Reader v0.0.1 • ${snapshot.data ?? '...'}',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: theme.textColor.withValues(alpha: 0.2),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Builds the theme selection section with interactive swatches.
  Widget _buildThemeSection(
    ReadingSettings settings,
    SettingsNotifier notifier,
    ReaderTheme theme,
    ReaderLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.theme,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            color: theme.textColor.withValues(alpha: 0.4),
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: ReaderThemeMode.values.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final mode = ReaderThemeMode.values[index];
              if (mode == ReaderThemeMode.custom) {
                return const SizedBox.shrink();
              }
              final modeTheme = ReaderTheme.getTheme(mode);
              final isSelected = settings.themeMode == mode;

              return GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  notifier.updateThemeMode(mode);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: modeTheme.backgroundColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? theme.accentColor
                          : theme.textColor.withValues(alpha: 0.08),
                      width: isSelected ? 3 : 1,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: theme.accentColor.withValues(alpha: 0.2),
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                          ]
                        : [],
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check_rounded,
                          color: modeTheme.textColor,
                          size: 22,
                        )
                      : null,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Builds the font size adjustment section.
  Widget _buildFontSizeSection(
    ReadingSettings settings,
    SettingsNotifier notifier,
    ReaderTheme theme,
    ReaderLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.fontSize,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                color: theme.textColor.withValues(alpha: 0.4),
                letterSpacing: 1.5,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: theme.accentColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${settings.fontSize.toInt()}px',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: theme.accentColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Text(
              'A',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: theme.textColor.withValues(alpha: 0.3),
              ),
            ),
            Expanded(
              child: SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: theme.accentColor,
                  inactiveTrackColor: theme.textColor.withValues(alpha: 0.05),
                  thumbColor: Colors.white,
                  trackHeight: 6,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 10,
                    elevation: 4,
                  ),
                  overlayColor: theme.accentColor.withValues(alpha: 0.1),
                ),
                child: Slider(
                  value: settings.fontSize,
                  min: 12,
                  max: 36,
                  onChanged: (val) {
                    if (val.toInt() != settings.fontSize.toInt()) {
                      HapticFeedback.selectionClick();
                    }
                    notifier.updateFontSize(val);
                  },
                ),
              ),
            ),
            Text(
              'A',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: theme.textColor.withValues(alpha: 0.3),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Builds the font family selection section.
  Widget _buildFontFamilySection(
    ReadingSettings settings,
    SettingsNotifier notifier,
    ReaderTheme theme,
    ReaderLocalizations l10n,
  ) {
    final fonts = ['Default', 'Serif', 'Sans Serif', 'Roboto', 'Georgia'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.fontFamily,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            color: theme.textColor.withValues(alpha: 0.4),
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: theme.textColor.withValues(alpha: 0.03),
            border: Border.all(color: theme.textColor.withValues(alpha: 0.05)),
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: fonts.length,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            itemBuilder: (context, index) {
              final font = fonts[index];
              final isSelected = settings.fontFamily == font;
              return GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  notifier.updateFontFamily(font);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 2,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color:
                        isSelected ? theme.backgroundColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : [],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    font,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected
                          ? theme.accentColor
                          : theme.textColor.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Builds the navigation mode (Vertical/Horizontal) section.
  /// Builds the navigation mode (Vertical/Horizontal) section.
  Widget _buildScrollModeSection(
    ReadingSettings settings,
    SettingsNotifier notifier,
    ReaderTheme theme,
    ReaderLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Navigation',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            color: theme.textColor.withValues(alpha: 0.4),
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: SegmentedButton<ScrollMode>(
            segments: const [
              ButtonSegment<ScrollMode>(
                value: ScrollMode.vertical,
                icon: Icon(Icons.swipe_vertical_outlined,color: Colors.black54,),
              ),
              ButtonSegment<ScrollMode>(
                value: ScrollMode.horizontal,
                icon: Icon(Icons.swap_horiz_outlined,color: Colors.black54,),
              ),
            ],
            selected: {settings.scrollMode},
            onSelectionChanged: (Set<ScrollMode> newSelection) {
              HapticFeedback.selectionClick();
              notifier.updateScrollMode(newSelection.first);
            },
            showSelectedIcon: false,
            style: _segmentedButtonStyle(theme),
          ),
        ),
      ],
    );
  }

  /// Builds the text alignment section.
  Widget _buildTextAlignSection(
    ReadingSettings settings,
    SettingsNotifier notifier,
    ReaderTheme theme,
    ReaderLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Align',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            color: theme.textColor.withValues(alpha: 0.4),
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: SegmentedButton<TextAlign>(
            segments: const [
              ButtonSegment<TextAlign>(
                value: TextAlign.left,
                icon: Icon(Icons.format_align_left_rounded,color: Colors.black54),
              ),
              ButtonSegment<TextAlign>(
                value: TextAlign.center,
                icon: Icon(Icons.format_align_center_rounded,color: Colors.black54),
              ),
              ButtonSegment<TextAlign>(
                value: TextAlign.right,
                icon: Icon(Icons.format_align_right_rounded,color: Colors.black54),
              ),
              ButtonSegment<TextAlign>(
                value: TextAlign.justify,
                icon: Icon(Icons.format_align_justify_rounded,color: Colors.black54),
              ),
            ],
            selected: {settings.textAlign},
            onSelectionChanged: (Set<TextAlign> newSelection) {
              HapticFeedback.selectionClick();
              notifier.updateTextAlign(newSelection.first);
            },
            showSelectedIcon: false,
            style: _segmentedButtonStyle(theme),
          ),
        ),
      ],
    );
  }

  ButtonStyle _segmentedButtonStyle(ReaderTheme theme) {
    return SegmentedButton.styleFrom(
      selectedBackgroundColor: Colors.grey.shade300,
      selectedForegroundColor: Colors.grey,
      foregroundColor: theme.textColor.withValues(alpha: 0.4),
      backgroundColor: theme.textColor.withValues(alpha: 0.05),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      visualDensity: VisualDensity.compact,
    );
  }

  /// Builds the line height/spacing adjustment section.
  Widget _buildSpacingSection(
    ReadingSettings settings,
    SettingsNotifier notifier,
    ReaderTheme theme,
    ReaderLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.lineSpacing,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            color: theme.textColor.withValues(alpha: 0.4),
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: theme.accentColor,
            inactiveTrackColor: theme.textColor.withValues(alpha: 0.05),
            thumbColor: Colors.white,
            trackHeight: 4,
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 8,
              elevation: 3,
            ),
          ),
          child: Slider(
            value: settings.lineHeight,
            min: 1.0,
            max: 2.5,
            onChanged: (val) => notifier.updateLineHeight(val),
          ),
        ),
      ],
    );
  }

  /// Builds system-level hardware controls (Brightness, etc.).
  Widget _buildSystemSection(
    ReadingSettings settings,
    SettingsNotifier notifier,
    ReaderTheme theme,
    ReaderLocalizations l10n,
  ) {
    return Column(
      children: [
        _buildSystemSwitch(
          label: l10n.keepAwake,
          value: settings.keepScreenAwake,
          onChanged: (val) => notifier.toggleKeepAwake(val),
          theme: theme,
          icon: Icons.wb_sunny_rounded,
        ),
        _buildSystemSwitch(
          label: l10n.hideStatusBar,
          value: settings.hideStatusBar,
          onChanged: (val) => notifier.toggleHideStatusBar(val),
          theme: theme,
          icon: Icons.fullscreen_rounded,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Icon(
              Icons.brightness_low_rounded,
              size: 18,
              color: theme.textColor.withValues(alpha: 0.3),
            ),
            Expanded(
              child: SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: theme.accentColor,
                  inactiveTrackColor: theme.textColor.withValues(alpha: 0.05),
                  thumbColor: Colors.white,
                  trackHeight: 4,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 8,
                    elevation: 3,
                  ),
                ),
                child: Slider(
                  value: settings.brightness,
                  min: 0.0,
                  max: 1.0,
                  onChanged: (val) => notifier.updateBrightness(val),
                ),
              ),
            ),
            Icon(
              Icons.brightness_high_rounded,
              size: 18,
              color: theme.textColor.withValues(alpha: 0.3),
            ),
          ],
        ),
      ],
    );
  }

  /// Builds a stylized system toggle switch.
  Widget _buildSystemSwitch({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
    required ReaderTheme theme,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: theme.textColor.withValues(alpha: 0.4)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: theme.textColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          Switch.adaptive(
            value: value,
            activeColor: theme.accentColor,
            onChanged: (val) {
              HapticFeedback.lightImpact();
              onChanged(val);
            },
          ),
        ],
      ),
    );
  }
}
