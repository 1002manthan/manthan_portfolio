import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});
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
          AnimatedReveal(child: SectionHeader(tag: 'Journey', title: 'Work\nexperience.')),
          const SizedBox(height: 56),
          AnimatedReveal(
            delay: const Duration(milliseconds: 200),
            child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 780),
              child: _Timeline()),
          ),
        ],
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = AppTheme.of(context).colors;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(children: [
            _Dot(active: true, c: c),
            Expanded(child: Container(width: 2, color: c.borderLight)),
            _Dot(active: false, c: c),
            Expanded(child: Container(width: 2, color: c.borderLight)),
          ]),
          const SizedBox(width: 28),
          Expanded(
            child: Column(children: [
              _ExpCard(
                period: '2024 · 6-Week Internship',
                role: 'Flutter Developer Intern',
                company: 'Infolabz IT Services Pvt. Ltd.',
                location: 'Ahmedabad, Gujarat',
                bullets: const [
                  'Built a complete Flutter News Application from scratch as the primary project.',
                  'Integrated REST APIs for real-time news fetching with categorized feeds.',
                  'Designed and implemented clean, responsive UI following Material guidelines.',
                  'Gained hands-on experience with Flutter architecture & state management.',
                ],
              ),
              const SizedBox(height: 32),
              _ExpCard(
                period: 'Earlier · Internship',
                role: 'Software Development Intern',
                company: 'Infolabz IT Services Pvt. Ltd.',
                location: 'Ahmedabad, Gujarat',
                bullets: const [
                  'Completed foundational internship gaining real-world industry exposure.',
                  'Strengthened software development practices and team workflow skills.',
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final bool active; final AppColors c;
  const _Dot({required this.active, required this.c});
  @override
  Widget build(BuildContext context) => Container(
    width: active ? 18 : 13, height: active ? 18 : 13,
    margin: EdgeInsets.symmetric(horizontal: active ? 0 : 2.5),
    decoration: BoxDecoration(
      color: active ? c.primary : c.border,
      shape: BoxShape.circle,
      boxShadow: active ? [BoxShadow(color: c.shadowRed, blurRadius: 14, spreadRadius: 2)] : [],
    ),
  );
}

class _ExpCard extends StatefulWidget {
  final String period, role, company, location;
  final List<String> bullets;
  const _ExpCard({required this.period, required this.role, required this.company, required this.location, required this.bullets});
  @override State<_ExpCard> createState() => _ExpCardState();
}
class _ExpCardState extends State<_ExpCard> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    final c = AppTheme.of(context).colors;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        width: double.infinity,
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: _hovered ? c.primaryXL : c.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _hovered ? c.primaryLight : c.borderLight),
          boxShadow: [BoxShadow(
            color: _hovered ? c.shadowRed : c.shadow,
            blurRadius: _hovered ? 28 : 10, offset: const Offset(0, 6),
          )],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: c.primaryXL, borderRadius: BorderRadius.circular(20),
                border: Border.all(color: c.primaryLight),
              ),
              child: Text(widget.period, style: GoogleFonts.dmSans(decoration: TextDecoration.none, 
                fontSize: 11.5, fontWeight: FontWeight.w700, color: c.primary, letterSpacing: 0.3)),
            ),
            const SizedBox(height: 14),
            Text(widget.role, style: GoogleFonts.playfairDisplay(decoration: TextDecoration.none, 
              fontSize: 24, fontWeight: FontWeight.w700, color: c.text, height: 1.2)),
            const SizedBox(height: 6),
            Row(children: [
              Container(width: 20, height: 1.5, color: c.primary),
              const SizedBox(width: 8),
              Text('${widget.company} · ${widget.location}',
                style: GoogleFonts.dmSans(decoration: TextDecoration.none, fontSize: 13.5, color: c.textSecondary, fontWeight: FontWeight.w500)),
            ]),
            const SizedBox(height: 18),
            Divider(color: c.borderLight, height: 1),
            const SizedBox(height: 16),
            ...widget.bullets.map((b) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(margin: const EdgeInsets.only(top: 8), width: 6, height: 6,
                  decoration: BoxDecoration(color: c.primary, shape: BoxShape.circle)),
                const SizedBox(width: 12),
                Expanded(child: Text(b, style: GoogleFonts.dmSans(decoration: TextDecoration.none, 
                  fontSize: 14, color: c.textSecondary, height: 1.65))),
              ]),
            )),
          ],
        ),
      ),
    );
  }
}
