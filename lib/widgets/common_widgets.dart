import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

// ── Section Header ───────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String tag;
  final String title;
  const SectionHeader({super.key, required this.tag, required this.title});

  @override
  Widget build(BuildContext context) {
    final c = AppTheme.of(context).colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 30, height: 2.5, color: c.primary),
            const SizedBox(width: 10),
            Text(
              tag.toUpperCase(),
              style: GoogleFonts.dmSans(decoration: TextDecoration.none, 
                fontSize: 11.5, fontWeight: FontWeight.w700,
                letterSpacing: 3, color: c.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          title,
          style: GoogleFonts.playfairDisplay(decoration: TextDecoration.none, 
            fontSize: 42, fontWeight: FontWeight.w700,
            color: c.text, height: 1.15,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: 50, height: 3.5,
          decoration: BoxDecoration(color: c.primary, borderRadius: BorderRadius.circular(2)),
        ),
      ],
    );
  }
}

// ── Animated Reveal ──────────────────────────────────────────────
class AnimatedReveal extends StatefulWidget {
  final Widget child;
  final Duration delay;
  const AnimatedReveal({super.key, required this.child, this.delay = Duration.zero});

  @override
  State<AnimatedReveal> createState() => _AnimatedRevealState();
}

class _AnimatedRevealState extends State<AnimatedReveal>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _fade  = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.14), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    Timer(const Duration(milliseconds: 300) + widget.delay, () { if (mounted) _ctrl.forward(); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) =>
      FadeTransition(opacity: _fade, child: SlideTransition(position: _slide, child: widget.child));
}

// ── Hover Card ───────────────────────────────────────────────────
class HoverCard extends StatefulWidget {
  final Widget child;
  final EdgeInsets padding;
  final double borderRadius;
  const HoverCard({super.key, required this.child,
    this.padding = const EdgeInsets.all(24), this.borderRadius = 14});

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = AppTheme.of(context).colors;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: widget.padding,
        transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(color: _hovered ? c.primaryLight : c.borderLight),
          boxShadow: [
            BoxShadow(
              color: _hovered ? c.shadowRed : c.shadow,
              blurRadius: _hovered ? 32 : 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}
