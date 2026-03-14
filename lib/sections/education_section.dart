import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});
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
          AnimatedReveal(child: SectionHeader(tag: 'Academic', title: 'Education\npath.')),
          const SizedBox(height: 54),
          AnimatedReveal(
            delay: const Duration(milliseconds: 200),
            child: LayoutBuilder(builder: (_, constraints) {
              if (constraints.maxWidth > 680) {
                return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(child: _EduCard(
                    badge: 'In Progress', badgeIcon: '🎓',
                    badgeColor: c.primary,
                    degree: 'Bachelor of Engineering',
                    field: 'Computer Engineering',
                    institute: 'Gujarat Technological University',
                    detail: 'Currently in 4th Semester',
                    year: '2023 — Present',
                    gradColors: [c.primaryXL, c.bgAlt],
                  )),
                  const SizedBox(width: 20),
                  Expanded(child: _EduCard(
                    badge: 'Completed', badgeIcon: '✅',
                    badgeColor: const Color(0xFF22C55E),
                    degree: 'Diploma in Engineering',
                    field: 'Computer Engineering',
                    institute: 'Gujarat State Board of Technical Education',
                    detail: 'Ahmedabad, Gujarat',
                    year: 'Completed',
                    gradColors: [Color(0xFFF0FFF4), Color(0xFFDCFCE7)],
                  )),
                ]);
              }
              return Column(children: [
                _EduCard(badge: 'In Progress', badgeIcon: '🎓', badgeColor: c.primary,
                  degree: 'Bachelor of Engineering', field: 'Computer Engineering',
                  institute: 'Gujarat Technological University', detail: 'Currently in 4th Semester',
                  year: '2023 — Present', gradColors: [c.primaryXL, c.bgAlt]),
                const SizedBox(height: 20),
                _EduCard(badge: 'Completed', badgeIcon: '✅', badgeColor: const Color(0xFF22C55E),
                  degree: 'Diploma in Engineering', field: 'Computer Engineering',
                  institute: 'Gujarat State Board of Technical Education', detail: 'Ahmedabad, Gujarat',
                  year: 'Completed', gradColors: const [Color(0xFFF0FFF4), Color(0xFFDCFCE7)]),
              ]);
            }),
          ),
        ],
      ),
    );
  }
}

class _EduCard extends StatefulWidget {
  final String badge, badgeIcon, degree, field, institute, detail, year;
  final Color badgeColor;
  final List<Color> gradColors;
  const _EduCard({required this.badge, required this.badgeIcon, required this.badgeColor,
    required this.degree, required this.field, required this.institute,
    required this.detail, required this.year, required this.gradColors});
  @override State<_EduCard> createState() => _EduCardState();
}
class _EduCardState extends State<_EduCard> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    final c = AppTheme.of(context).colors;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
        decoration: BoxDecoration(
          color: c.surface, borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _hovered ? widget.badgeColor.withOpacity(0.35) : c.borderLight),
          boxShadow: [BoxShadow(
            color: _hovered ? widget.badgeColor.withOpacity(0.14) : c.shadow,
            blurRadius: _hovered ? 32 : 10, offset: const Offset(0, 6),
          )],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100, width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: widget.gradColors,
                    begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.badgeIcon, style: const TextStyle(fontSize: 36)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: c.surface.withOpacity(0.88),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Container(width: 7, height: 7,
                          decoration: BoxDecoration(color: widget.badgeColor, shape: BoxShape.circle)),
                        const SizedBox(width: 6),
                        Text(widget.badge, style: GoogleFonts.dmSans(decoration: TextDecoration.none, 
                          fontSize: 11.5, fontWeight: FontWeight.w700, color: widget.badgeColor)),
                      ]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(widget.degree, style: GoogleFonts.playfairDisplay(decoration: TextDecoration.none, 
                    fontSize: 20, fontWeight: FontWeight.w700, color: c.text, height: 1.2)),
                  const SizedBox(height: 6),
                  Text(widget.field, style: GoogleFonts.dmSans(decoration: TextDecoration.none, 
                    fontSize: 14, fontWeight: FontWeight.w600, color: widget.badgeColor)),
                  const SizedBox(height: 10),
                  Text(widget.institute, style: GoogleFonts.dmSans(decoration: TextDecoration.none, 
                    fontSize: 13, color: c.textSecondary, height: 1.5)),
                  const SizedBox(height: 4),
                  Text(widget.detail, style: GoogleFonts.dmSans(decoration: TextDecoration.none, fontSize: 12.5, color: c.textMuted)),
                  const SizedBox(height: 16),
                  Row(children: [
                    Container(width: 20, height: 1.5, color: widget.badgeColor.withOpacity(0.5)),
                    const SizedBox(width: 8),
                    Text(widget.year, style: GoogleFonts.dmSans(decoration: TextDecoration.none, 
                      fontSize: 12.5, fontWeight: FontWeight.w600, color: c.textMuted)),
                  ]),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
