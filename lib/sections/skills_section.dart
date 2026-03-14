import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static const _skills = [
    ('🐦', 'Flutter',         0.80, 'Cross-platform mobile & web development'),
    ('🎯', 'Dart',            0.78, 'Flutter\'s expressive, typed language'),
    ('☕', 'Java',            0.70, 'OOP, data structures & algorithms'),
    ('🎨', 'UI / UX Design',  0.82, 'Pixel-perfect, aligned interfaces'),
    ('🐙', 'Git & GitHub',    0.72, 'Version control & collaboration'),
    ('💡', 'Problem Solving', 0.85, 'Brainstorming & logical thinking'),
  ];

  @override
  Widget build(BuildContext context) {
    final c = AppTheme.of(context).colors;
    final isWide = MediaQuery.of(context).size.width > 900;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      color: c.bgAlt,
      padding: EdgeInsets.symmetric(horizontal: isWide ? 80 : 28, vertical: 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AnimatedReveal(child: SectionHeader(tag: 'Skill Set', title: 'Tools of\nthe craft.')),
          const SizedBox(height: 54),
          AnimatedReveal(
            delay: const Duration(milliseconds: 200),
            child: LayoutBuilder(builder: (_, constraints) {
              final cols = constraints.maxWidth > 700 ? 3 : (constraints.maxWidth > 450 ? 2 : 1);
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: cols,
                crossAxisSpacing: 16, mainAxisSpacing: 16,
                childAspectRatio: cols == 1 ? 2.2 : 1.65,
                children: _skills.map((s) => _SkillCard(
                  icon: s.$1, name: s.$2, level: s.$3, desc: s.$4,
                )).toList(),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatefulWidget {
  final String icon, name, desc;
  final double level;
  const _SkillCard({required this.icon, required this.name, required this.level, required this.desc});
  @override State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _barCtrl;
  late Animation<double> _barAnim;

  @override
  void initState() {
    super.initState();
    _barCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _barAnim = Tween<double>(begin: 0, end: widget.level)
        .animate(CurvedAnimation(parent: _barCtrl, curve: Curves.easeOutCubic));
    Timer(const Duration(milliseconds: 700), () { if (mounted) _barCtrl.forward(); });
  }

  @override void dispose() { _barCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final c = AppTheme.of(context).colors;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.all(22),
        transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _hovered ? c.primaryLight : c.borderLight),
          boxShadow: [BoxShadow(
            color: _hovered ? c.shadowRed : c.shadow,
            blurRadius: _hovered ? 32 : 10, offset: const Offset(0, 6),
          )],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: 44, height: 44,
                decoration: BoxDecoration(
                  color: _hovered ? c.primaryXL : c.bgAlt,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: Text(widget.icon, style: const TextStyle(fontSize: 22))),
              ),
              const Spacer(),
              AnimatedBuilder(
                animation: _barAnim,
                builder: (_, __) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: c.primaryXL, borderRadius: BorderRadius.circular(20)),
                  child: Text('${(_barAnim.value * 100).toInt()}%',
                    style: GoogleFonts.dmSans(decoration: TextDecoration.none, fontSize: 11.5, fontWeight: FontWeight.w700, color: c.primary)),
                ),
              ),
            ]),
            const SizedBox(height: 14),
            Text(widget.name, style: GoogleFonts.dmSans(decoration: TextDecoration.none, fontSize: 15, fontWeight: FontWeight.w700, color: c.text)),
            const SizedBox(height: 4),
            Text(widget.desc, style: GoogleFonts.dmSans(decoration: TextDecoration.none, fontSize: 12.5, color: c.textMuted, height: 1.5)),
            const SizedBox(height: 14),
            Container(
              height: 5,
              decoration: BoxDecoration(color: c.borderLight, borderRadius: BorderRadius.circular(3)),
              child: AnimatedBuilder(
                animation: _barAnim,
                builder: (_, __) => FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _barAnim.value,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [c.primaryDark, c.primary]),
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [BoxShadow(color: c.shadowRed, blurRadius: 6)],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
