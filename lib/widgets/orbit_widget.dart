import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

// ─────────────────────────────────────────────────────────────────
//  OrbitWidget  —  Glowing core + 2 counter-rotating skill rings
// ─────────────────────────────────────────────────────────────────
class OrbitWidget extends StatefulWidget {
  const OrbitWidget({super.key});

  @override
  State<OrbitWidget> createState() => _OrbitWidgetState();
}

class _OrbitWidgetState extends State<OrbitWidget>
    with TickerProviderStateMixin {
  late AnimationController _innerCtrl;   // inner ring  — CW
  late AnimationController _outerCtrl;   // outer ring  — CCW
  late AnimationController _pulseCtrl;   // core pulse
  late AnimationController _floatCtrl;   // whole widget float

  static const _innerItems = [
    _SkillItem('🐦', 'Flutter'),
    _SkillItem('🎯', 'Dart'),
    _SkillItem('☕', 'Java'),
  ];

  static const _outerItems = [
    _SkillItem('🎨', 'UI/UX'),
    _SkillItem('🐙', 'GitHub'),
    _SkillItem('💡', 'Ideas'),
    _SkillItem('📱', 'Mobile'),
  ];

  @override
  void initState() {
    super.initState();

    _innerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    )..repeat();

    _outerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 22),
    )..repeat();

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _innerCtrl.dispose();
    _outerCtrl.dispose();
    _pulseCtrl.dispose();
    _floatCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = AppTheme.of(context).colors;

    return AnimatedBuilder(
      animation: _floatCtrl,
      builder: (_, child) {
        final floatY = Tween<double>(begin: -8, end: 8)
            .evaluate(CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut));
        return Transform.translate(
          offset: Offset(0, floatY),
          child: child,
        );
      },
      child: SizedBox(
        width: 360,
        height: 360,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // ── Outermost ambient glow ──────────────────────────
            AnimatedBuilder(
              animation: _pulseCtrl,
              builder: (_, __) {
                final scale = Tween<double>(begin: 0.92, end: 1.05)
                    .evaluate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));
                return Transform.scale(
                  scale: scale,
                  child: Container(
                    width: 340, height: 340,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          c.primary.withOpacity(0.08),
                          c.primary.withOpacity(0.03),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                );
              },
            ),

            // ── Outer orbit track ───────────────────────────────
            Container(
              width: 320, height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: c.primary.withOpacity(0.10),
                  width: 1,
                ),
              ),
            ),

            // ── Inner orbit track ───────────────────────────────
            Container(
              width: 210, height: 210,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: c.primary.withOpacity(0.16),
                  width: 1.5,
                ),
              ),
            ),

            // ── Outer ring (CCW) ────────────────────────────────
            AnimatedBuilder(
              animation: _outerCtrl,
              builder: (_, __) {
                return SizedBox(
                  width: 320, height: 320,
                  child: Stack(
                    alignment: Alignment.center,
                    children: List.generate(_outerItems.length, (i) {
                      final angle = -_outerCtrl.value * 2 * math.pi   // CCW
                          + (i / _outerItems.length) * 2 * math.pi;
                      final x = 160 * math.cos(angle);
                      final y = 160 * math.sin(angle);
                      return Transform.translate(
                        offset: Offset(x, y),
                        child: _OrbitIcon(
                          item: _outerItems[i],
                          orbitAngle: angle,
                          colors: c,
                          size: 42,
                        ),
                      );
                    }),
                  ),
                );
              },
            ),

            // ── Inner ring (CW) ─────────────────────────────────
            AnimatedBuilder(
              animation: _innerCtrl,
              builder: (_, __) {
                return SizedBox(
                  width: 210, height: 210,
                  child: Stack(
                    alignment: Alignment.center,
                    children: List.generate(_innerItems.length, (i) {
                      final angle = _innerCtrl.value * 2 * math.pi   // CW
                          + (i / _innerItems.length) * 2 * math.pi;
                      final x = 105 * math.cos(angle);
                      final y = 105 * math.sin(angle);
                      return Transform.translate(
                        offset: Offset(x, y),
                        child: _OrbitIcon(
                          item: _innerItems[i],
                          orbitAngle: angle,
                          colors: c,
                          size: 48,
                        ),
                      );
                    }),
                  ),
                );
              },
            ),

            // ── Glowing core ────────────────────────────────────
            _GlowingCore(pulseCtrl: _pulseCtrl, colors: c),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
//  Glowing Core
// ─────────────────────────────────────────────────────────────────
class _GlowingCore extends StatelessWidget {
  final AnimationController pulseCtrl;
  final AppColors colors;
  const _GlowingCore({required this.pulseCtrl, required this.colors});

  @override
  Widget build(BuildContext context) {
    final c = colors;
    return AnimatedBuilder(
      animation: pulseCtrl,
      builder: (_, __) {
        final glow = Tween<double>(begin: 20, end: 40)
            .evaluate(CurvedAnimation(parent: pulseCtrl, curve: Curves.easeInOut));
        final innerGlow = Tween<double>(begin: 0.5, end: 0.85)
            .evaluate(CurvedAnimation(parent: pulseCtrl, curve: Curves.easeInOut));

        return Stack(
          alignment: Alignment.center,
          children: [
            // Soft outer halo
            Container(
              width: 100, height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: c.primary.withOpacity(0.18), blurRadius: glow, spreadRadius: 4),
                ],
              ),
            ),
            // Core circle
            Container(
              width: 80, height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color.lerp(c.primary, Colors.white, 0.35)!.withOpacity(innerGlow),
                    c.primary.withOpacity(innerGlow * 0.8),
                  ],
                ),
                boxShadow: [
                  BoxShadow(color: c.primary.withOpacity(0.45), blurRadius: glow * 0.6, spreadRadius: 2),
                ],
              ),
            ),
            // "M" letter
            Text(
              'M',
              style: GoogleFonts.playfairDisplay(
                decoration: TextDecoration.none,
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: Colors.white.withOpacity(0.92),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────
//  Orbit Icon — individual hoverable skill icon on the ring
// ─────────────────────────────────────────────────────────────────
class _OrbitIcon extends StatefulWidget {
  final _SkillItem item;
  final double orbitAngle;
  final AppColors colors;
  final double size;

  const _OrbitIcon({
    required this.item,
    required this.orbitAngle,
    required this.colors,
    required this.size,
  });

  @override
  State<_OrbitIcon> createState() => _OrbitIconState();
}

class _OrbitIconState extends State<_OrbitIcon>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _hoverCtrl;
  late Animation<double> _hoverAnim;

  @override
  void initState() {
    super.initState();
    _hoverCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _hoverAnim = CurvedAnimation(parent: _hoverCtrl, curve: Curves.easeOutBack);
  }

  @override
  void dispose() { _hoverCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final c = widget.colors;

    return MouseRegion(
      onEnter: (_) {
        setState(() => _hovered = true);
        _hoverCtrl.forward();
      },
      onExit: (_) {
        setState(() => _hovered = false);
        _hoverCtrl.reverse();
      },
      cursor: SystemMouseCursors.basic,
      child: AnimatedBuilder(
        animation: _hoverAnim,
        builder: (_, __) {
          final scale = Tween<double>(begin: 1.0, end: 1.28).evaluate(_hoverAnim);
          return Transform.scale(
            scale: scale,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon bubble
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _hovered ? c.primaryXL : c.surface,
                    border: Border.all(
                      color: _hovered ? c.primary.withOpacity(0.6) : c.borderLight,
                      width: _hovered ? 1.5 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _hovered ? c.shadowRed : c.shadow,
                        blurRadius: _hovered ? 18 : 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      widget.item.emoji,
                      style: TextStyle(fontSize: widget.size * 0.44),
                    ),
                  ),
                ),
                // Label tooltip on hover
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 180),
                  opacity: _hovered ? 1.0 : 0.0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: c.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        widget.item.label,
                        style: GoogleFonts.dmSans(
                          decoration: TextDecoration.none,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
//  Data class
// ─────────────────────────────────────────────────────────────────
class _SkillItem {
  final String emoji, label;
  const _SkillItem(this.emoji, this.label);
}
