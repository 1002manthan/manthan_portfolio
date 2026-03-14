import 'dart:ui';

import 'package:flutter/material.dart';

// ── Color tokens ────────────────────────────────────────────────
class AppColors {
  final bool isDark;
  const AppColors(this.isDark);

  // Always red
  Color get primary      => const Color(0xFFE8173A);
  Color get primaryDark  => const Color(0xFFBF0F2D);
  Color get primaryLight => const Color(0xFFFFE4E8);
  Color get primaryXL    => isDark ? const Color(0xFF2A0A10) : const Color(0xFFFFF0F2);
  Color get shadowRed    => const Color(0x20E8173A);

  // Backgrounds
  Color get bg           => isDark ? const Color(0xFF0C0C11) : const Color(0xFFFAFAFA);
  Color get bgAlt        => isDark ? const Color(0xFF111118) : const Color(0xFFFFF5F6);
  Color get surface      => isDark ? const Color(0xFF17171F) : const Color(0xFFFFFFFF);
  Color get surfaceAlt   => isDark ? const Color(0xFF1C1C26) : const Color(0xFFF9FAFB);

  // Text
  Color get text           => isDark ? const Color(0xFFF0EDE8) : const Color(0xFF111827);
  Color get textSub        => isDark ? const Color(0xFFCBC8C0) : const Color(0xFF374151);
  Color get textSecondary  => isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
  Color get textMuted      => isDark ? const Color(0xFF555566) : const Color(0xFF9CA3AF);

  // Borders
  Color get border       => isDark ? const Color(0xFF28283A) : const Color(0xFFE5E7EB);
  Color get borderLight  => isDark ? const Color(0xFF1E1E2A) : const Color(0xFFF3F4F6);

  // Shadows
  Color get shadow       => isDark ? const Color(0x44000000) : const Color(0x0D000000);

  // Nav
  Color get navBg        => isDark
      ? const Color(0xF2111118)
      : const Color(0xF5FFFFFF);
  Color get navBorder    => isDark
      ? const Color(0xFF1E1E2A)
      : const Color(0xFFF3F4F6);

  // Hero gradient
  List<Color> get heroBg => isDark
      ? [const Color(0xFF0C0C11), const Color(0xFF12111A), const Color(0xFF0E0E14)]
      : [const Color(0xFFFFFFFF), const Color(0xFFFFF8F9), const Color(0xFFFFFAFC)];

  // Dot grid
  Color get dotColor     => isDark
      ? const Color(0xFFE8173A).withOpacity(0.08)
      : const Color(0xFFE8173A).withOpacity(0.05);

  // Skills bg
  Color get sectionAlt   => isDark ? const Color(0xFF0E0E15) : const Color(0xFFFFF5F6);
}

// ── InheritedWidget ─────────────────────────────────────────────
class AppTheme extends InheritedWidget {
  final AppColors colors;
  final VoidCallback onToggle;

  const AppTheme({
    super.key,
    required this.colors,
    required this.onToggle,
    required super.child,
  });

  static AppTheme of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<AppTheme>();
    assert(result != null, 'No AppTheme found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppTheme old) => colors.isDark != old.colors.isDark;
}

// ── Smooth Scroll Behavior ───────────────────────────────────────
class SmoothScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const ClampingScrollPhysics();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
  };

  @override
  Widget buildOverscrollIndicator(
    BuildContext context, Widget child, ScrollableDetails details) => child;
}
