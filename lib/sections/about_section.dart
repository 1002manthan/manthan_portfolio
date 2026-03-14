import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});
  @override
  Widget build(BuildContext context) {
    final c = AppTheme.of(context).colors;
    final isWide = MediaQuery.of(context).size.width > 900;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      color: c.surface,
      padding: EdgeInsets.symmetric(horizontal: isWide ? 80 : 28, vertical: 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AnimatedReveal(child: SectionHeader(tag: 'About Me', title: 'Who I\'am.')),
          const SizedBox(height: 56),
          isWide
              ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(flex: 55, child: _AboutText(c)),
                  const SizedBox(width: 56),
                  Expanded(flex: 35, child: _StatsGrid(c)),
                ])
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  _AboutText(c),
                  const SizedBox(height: 40),
                  _StatsGrid(c),
                ]),
        ],
      ),
    );
  }
}

class _AboutText extends StatelessWidget {
  final AppColors c;
  const _AboutText(this.c);
  @override
  Widget build(BuildContext context) {
    return AnimatedReveal(
      delay: const Duration(milliseconds: 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _para(c, [
            _s(c, "I'm "), _b(c, "Manthan Suthar"),
            _s(c, ", a Computer Engineering student from Ahmedabad with a deep passion for building things that are not just functional — but "),
            _b(c, "beautiful, clean, and perfectly aligned"), _s(c, "."),
          ]),
          const SizedBox(height: 18),
          _para(c, [
            _s(c, "UI/UX isn't just a skill for me — it's a "), _b(c, "mindset"),
            _s(c, ". I believe every pixel, every transition, and every interaction should be intentional. "),
            _b(c, "Brainstorming"), _s(c, " and turning ideas into polished experiences is what drives me every day."),
          ]),
          const SizedBox(height: 18),
          _para(c, [
            _s(c, "Currently in my "), _b(c, "4th semester of BE in Computer Engineering"),
            _s(c, ", I'm ready to take on new challenges, learn at speed, and ship products that genuinely matter."),
          ]),
          const SizedBox(height: 32),
          Wrap(spacing: 10, runSpacing: 10, children: [
            _Chip('Flutter', c), _Chip('Dart', c), _Chip('Java', c),
            _Chip('UI/UX Design', c), _Chip('GitHub', c), _Chip('Problem Solving', c),
          ]),
        ],
      ),
    );
  }

  Widget _para(AppColors c, List<TextSpan> spans) =>
      RichText(text: TextSpan(
        style: GoogleFonts.dmSans(decoration: TextDecoration.none, fontSize: 15.5, color: c.textSecondary, height: 1.85),
        children: spans));
  TextSpan _s(AppColors c, String t) => TextSpan(text: t,
    style: GoogleFonts.dmSans(decoration: TextDecoration.none, fontSize: 15.5, color: c.textSecondary, height: 1.85));
  TextSpan _b(AppColors c, String t) => TextSpan(text: t,
    style: GoogleFonts.dmSans(decoration: TextDecoration.none, fontSize: 15.5, color: c.text, height: 1.85, fontWeight: FontWeight.w600));
}

class _Chip extends StatelessWidget {
  final String label; final AppColors c;
  const _Chip(this.label, this.c);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: c.primaryXL, borderRadius: BorderRadius.circular(24),
      border: Border.all(color: c.primaryLight),
    ),
    child: Text(label, style: GoogleFonts.dmSans(decoration: TextDecoration.none, fontSize: 13, fontWeight: FontWeight.w600, color: c.primary)),
  );
}

class _StatsGrid extends StatelessWidget {
  final AppColors c;
  const _StatsGrid(this.c);
  @override
  Widget build(BuildContext context) => AnimatedReveal(
    delay: const Duration(milliseconds: 300),
    child: GridView.count(
      crossAxisCount: 2, shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 14, mainAxisSpacing: 14, childAspectRatio: 1.25,
      children: [
        _StatTile('2',   'Internships\nCompleted', c),
        _StatTile('2+',  'Apps\nShipped',          c),
        _StatTile('4th', 'Semester\nBE in CE',     c),
        _StatTile('∞',   'Ideas\nto Build',        c),
      ],
    ),
  );
}

class _StatTile extends StatefulWidget {
  final String num, label; final AppColors c;
  const _StatTile(this.num, this.label, this.c);
  @override State<_StatTile> createState() => _StatTileState();
}
class _StatTileState extends State<_StatTile> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    final c = widget.c;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(22),
        transform: Matrix4.translationValues(0, _hovered ? -5 : 0, 0),
        decoration: BoxDecoration(
          color: _hovered ? c.primaryXL : c.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _hovered ? c.primaryLight : c.borderLight),
          boxShadow: [BoxShadow(
            color: _hovered ? c.shadowRed : c.shadow,
            blurRadius: _hovered ? 24 : 8, offset: const Offset(0, 4),
          )],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(widget.num, style: GoogleFonts.playfairDisplay(decoration: TextDecoration.none, fontSize: 38, fontWeight: FontWeight.w700, color: c.primary, height: 1)),
          const SizedBox(height: 8),
          Text(widget.label, style: GoogleFonts.dmSans(decoration: TextDecoration.none, fontSize: 12.5, color: c.textSecondary, height: 1.5)),
        ]),
      ),
    );
  }
}
