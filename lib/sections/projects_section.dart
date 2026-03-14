import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

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
          AnimatedReveal(child: SectionHeader(tag: 'Work', title: 'Featured\nprojects.')),
          const SizedBox(height: 54),
          // Row 1 — Flutter News App + Battleship War
          AnimatedReveal(
            delay: const Duration(milliseconds: 150),
            child: LayoutBuilder(builder: (_, constraints) {
              final isGrid = constraints.maxWidth > 720;
              if (isGrid) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _ProjectCard(data: _projects[0])),
                    const SizedBox(width: 20),
                    Expanded(child: _ProjectCard(data: _projects[1])),
                  ],
                );
              }
              return Column(children: [
                _ProjectCard(data: _projects[0]),
                const SizedBox(height: 20),
                _ProjectCard(data: _projects[1]),
              ]);
            }),
          ),
          const SizedBox(height: 20),
          // Row 2 — Battleship Console + BookYourShow
          AnimatedReveal(
            delay: const Duration(milliseconds: 280),
            child: LayoutBuilder(builder: (_, constraints) {
              final isGrid = constraints.maxWidth > 720;
              if (isGrid) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _ProjectCard(data: _projects[2])),
                    const SizedBox(width: 20),
                    Expanded(child: _ProjectCard(data: _projects[3])),
                  ],
                );
              }
              return Column(children: [
                _ProjectCard(data: _projects[2]),
                const SizedBox(height: 20),
                _ProjectCard(data: _projects[3]),
              ]);
            }),
          ),
        ],
      ),
    );
  }

  static const _projects = [
    _PData(
      emoji: '📰',
      title: 'Flutter News App',
      description:
      'A fully functional news application built with Flutter & Dart. Features real-time news from REST API, categorized feeds, clean article reading experience, and smooth navigation. Built as primary internship project at Infolabz.',
      tags: ['Flutter', 'Dart', 'REST API', 'UI/UX'],
      accent: Color(0xFFE8173A),
      github: 'https://github.com/1002manthan/Flutter-News-Application',
      live: '',
    ),
    _PData(
      emoji: '⚔️',
      title: 'The Battleship War',
      description:
      'A complete JavaFX Battleship game with parchment & deep teal theme. Full fleet: Flagship, Man-of-War, Brigantine, Corsair & Sloop. Animated combat log, hit/miss/sunk states, R/C hints, and a stats panel. A Upgraded version of Battleship Console game, my One of the favorite and oldest project!',
      tags: ['JavaFX', 'Java', 'OOP', 'Game Logic Dev'],
      accent: Color(0xFF1B6CA8),
      github: 'https://github.com/1002manthan/BattleshipFX',
      live: '',
    ),
    _PData(
      emoji: '⚓',
      title: 'Battleship Console Game',
      description:
      'A Java command-line Battleship game built with clean OOP principles. Features a multi-grid board system, turn-based logic, ship placement, and hit/miss tracking — all in the terminal.',
      tags: ['Java', 'OOP Logic', 'CLI', 'Grid Board'],
      accent: Color(0xFF0F766E),
      github: 'https://github.com/1002manthan/Battleship-Console-Game',
      live: '',
    ),
    _PData(
      emoji: '🎬',
      title: 'BookYourShow',
      description:
      'A live movie & show ticket booking website. Includes a full movie listing (Harry Potter collection + trending films), category browsing, user login/signup, and a clean responsive UI built with HTML, CSS & JS.',
      tags: ['HTML', 'CSS', 'JavaScript', 'Web'],
      accent: Color(0xFF7C3AED),
      github: 'https://github.com/1002manthan/BookYourShow',
      live: 'https://1002manthan.github.io/BookYourShow/',
    ),
  ];
}

// ─────────────────────────────────────────────────────────────────
//  Data
// ─────────────────────────────────────────────────────────────────
class _PData {
  final String emoji, title, description, github, live;
  final List<String> tags;
  final Color accent;
  const _PData({
    required this.emoji,
    required this.title,
    required this.description,
    required this.tags,
    required this.accent,
    required this.github,
    required this.live,
  });
}

// ─────────────────────────────────────────────────────────────────
//  Project Card
// ─────────────────────────────────────────────────────────────────
class _ProjectCard extends StatefulWidget {
  final _PData data;
  const _ProjectCard({super.key, required this.data});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = AppTheme.of(context).colors;
    final d = widget.data;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 230),
        transform: Matrix4.translationValues(0, _hovered ? -8 : 0, 0),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _hovered ? d.accent.withOpacity(0.4) : c.borderLight,
            width: _hovered ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered ? d.accent.withOpacity(0.14) : c.shadow,
              blurRadius: _hovered ? 40 : 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Card Header ──────────────────────────────────
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      d.accent.withOpacity(c.isDark ? 0.22 : 0.09),
                      d.accent.withOpacity(c.isDark ? 0.10 : 0.04),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Subtle dot pattern
                    Positioned.fill(child: CustomPaint(painter: _DotPatternPainter(d.accent))),
                    // Emoji
                    Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
                        child: Container(
                          width: 72, height: 72,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: d.accent.withOpacity(c.isDark ? 0.18 : 0.10),
                            border: Border.all(
                              color: d.accent.withOpacity(_hovered ? 0.5 : 0.2),
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Text(d.emoji, style: const TextStyle(fontSize: 34)),
                          ),
                        ),
                      ),
                    ),
                    // Top-right: first tag badge
                    Positioned(
                      top: 14, right: 14,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: c.surface.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: d.accent.withOpacity(0.2)),
                        ),
                        child: Text(
                          d.tags[0],
                          style: GoogleFonts.dmSans(
                            decoration: TextDecoration.none,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: d.accent,
                          ),
                        ),
                      ),
                    ),
                    // Live badge — top left, only if live URL exists
                    if (d.live.isNotEmpty)
                      Positioned(
                        top: 14, left: 14,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFF22C55E).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFF22C55E).withOpacity(0.45),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6, height: 6,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF22C55E),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Live',
                                style: GoogleFonts.dmSans(
                                  decoration: TextDecoration.none,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF22C55E),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // ── Card Body ────────────────────────────────────
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tags
                    Wrap(
                      spacing: 7, runSpacing: 7,
                      children: d.tags
                          .map((t) => _TagPill(label: t, color: d.accent, c: c))
                          .toList(),
                    ),
                    const SizedBox(height: 13),
                    // Title
                    Text(
                      d.title,
                      style: GoogleFonts.playfairDisplay(
                        decoration: TextDecoration.none,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: c.text,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 9),
                    // Description
                    Text(
                      d.description,
                      style: GoogleFonts.dmSans(
                        decoration: TextDecoration.none,
                        fontSize: 13,
                        color: c.textSecondary,
                        height: 1.7,
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Links
                    Row(
                      children: [
                        if (d.github.isNotEmpty)
                          _LinkBtn(
                            icon: '🐙',
                            label: 'GitHub',
                            onTap: () => launchUrl(Uri.parse(d.github)),
                            c: c,
                          ),
                        if (d.live.isNotEmpty) ...[
                          const SizedBox(width: 10),
                          _LinkBtn(
                            icon: '🚀',
                            label: 'Live Demo',
                            onTap: () => launchUrl(Uri.parse(d.live)),
                            c: c,
                            filled: true,
                            fillColor: d.accent,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
//  Tag Pill
// ─────────────────────────────────────────────────────────────────
class _TagPill extends StatelessWidget {
  final String label;
  final Color color;
  final AppColors c;
  const _TagPill({required this.label, required this.color, required this.c});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(c.isDark ? 0.15 : 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.28)),
      ),
      child: Text(
        label,
        style: GoogleFonts.dmSans(
          decoration: TextDecoration.none,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
//  Link Button
// ─────────────────────────────────────────────────────────────────
class _LinkBtn extends StatefulWidget {
  final String icon, label;
  final VoidCallback onTap;
  final AppColors c;
  final bool filled;
  final Color? fillColor;
  const _LinkBtn({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.c,
    this.filled = false,
    this.fillColor,
  });

  @override
  State<_LinkBtn> createState() => _LinkBtnState();
}

class _LinkBtnState extends State<_LinkBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.c;
    final fill = widget.fillColor ?? c.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            color: widget.filled
                ? (_hovered ? fill.withOpacity(0.85) : fill)
                : (_hovered ? c.primaryXL : c.bgAlt),
            borderRadius: BorderRadius.circular(8),
            border: widget.filled
                ? null
                : Border.all(color: _hovered ? c.primaryLight : c.border),
            boxShadow: widget.filled && _hovered
                ? [BoxShadow(color: fill.withOpacity(0.3), blurRadius: 14, offset: const Offset(0, 4))]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.icon, style: const TextStyle(fontSize: 13)),
              const SizedBox(width: 6),
              Text(
                widget.label,
                style: GoogleFonts.dmSans(
                  decoration: TextDecoration.none,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: widget.filled
                      ? Colors.white
                      : (_hovered ? c.primary : c.textSecondary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
//  Dot Pattern Painter (card header bg texture)
// ─────────────────────────────────────────────────────────────────
class _DotPatternPainter extends CustomPainter {
  final Color accent;
  const _DotPatternPainter(this.accent);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = accent.withOpacity(0.07);
    const spacing = 18.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_) => false;
}