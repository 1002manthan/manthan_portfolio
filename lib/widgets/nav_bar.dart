import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class NavBar extends StatelessWidget {
  final bool isScrolled;
  final void Function(String) onTap;
  const NavBar({super.key, required this.isScrolled, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final c   = AppTheme.of(context).colors;
    final tog = AppTheme.of(context).onToggle;
    final isWide = MediaQuery.of(context).size.width > 760;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 72,
      decoration: BoxDecoration(
        color: isScrolled ? c.navBg : Colors.transparent,
        boxShadow: isScrolled
            ? [BoxShadow(color: c.shadow, blurRadius: 30, offset: const Offset(0, 4))]
            : [],
        border: isScrolled
            ? Border(bottom: BorderSide(color: c.navBorder))
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isWide ? 60 : 24),
        child: Row(
          children: [
            // Logo
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'Manthan',
                  style: GoogleFonts.playfairDisplay(decoration: TextDecoration.none, 
                    fontSize: 22, fontWeight: FontWeight.w700, color: c.text,
                  ),
                ),
                TextSpan(
                  text: '.',
                  style: GoogleFonts.playfairDisplay(decoration: TextDecoration.none, 
                    fontSize: 22, fontWeight: FontWeight.w700, color: c.primary,
                  ),
                ),
              ]),
            ),
            const Spacer(),
            if (isWide) ...[
              for (final item in ['about', 'skills', 'projects', 'experience', 'education'])
                _NavLink(label: item, onTap: () => onTap(item), colors: c),
              const SizedBox(width: 12),
              _ContactBtn(onTap: () => onTap('contact'), colors: c),
              const SizedBox(width: 14),
            ],
            // ── Dark / Light toggle ──────────────────────────────
            _ThemeToggle(isDark: c.isDark, onToggle: tog, colors: c),
          ],
        ),
      ),
    );
  }
}

// ── Toggle Button ────────────────────────────────────────────────
class _ThemeToggle extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggle;
  final AppColors colors;
  const _ThemeToggle({required this.isDark, required this.onToggle, required this.colors});

  @override
  State<_ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<_ThemeToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 350));
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutCubic);
    if (widget.isDark) _ctrl.value = 1.0;
  }

  @override
  void didUpdateWidget(_ThemeToggle old) {
    super.didUpdateWidget(old);
    if (widget.isDark != old.isDark) {
      widget.isDark ? _ctrl.forward() : _ctrl.reverse();
    }
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final c = widget.colors;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onToggle,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: 56, height: 30,
          decoration: BoxDecoration(
            color: widget.isDark ? c.primary : c.borderLight,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: _hovered ? c.primary : c.border,
              width: 1.5,
            ),
            boxShadow: _hovered
                ? [BoxShadow(color: c.shadowRed, blurRadius: 12)]
                : [],
          ),
          child: AnimatedBuilder(
            animation: _anim,
            builder: (_, __) => Padding(
              padding: const EdgeInsets.all(3),
              child: Align(
                alignment: Alignment(_anim.value * 2 - 1, 0),
                child: Container(
                  width: 22, height: 22,
                  decoration: BoxDecoration(
                    color: widget.isDark ? Colors.white : c.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: c.shadowRed, blurRadius: 6, offset: const Offset(0, 2)),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      widget.isDark ? '🌙' : '☀️',
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Nav Link ─────────────────────────────────────────────────────
class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final AppColors colors;
  const _NavLink({required this.label, required this.onTap, required this.colors});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.colors;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 180),
                style: GoogleFonts.dmSans(decoration: TextDecoration.none, 
                  fontSize: 13.5,
                  fontWeight: _hovered ? FontWeight.w600 : FontWeight.w400,
                  color: _hovered ? c.primary : c.textSecondary,
                  letterSpacing: 0.2,
                ),
                child: Text(widget.label[0].toUpperCase() + widget.label.substring(1)),
              ),
              const SizedBox(height: 3),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2, width: _hovered ? 28 : 0,
                decoration: BoxDecoration(
                  color: c.primary,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Contact Button ───────────────────────────────────────────────
class _ContactBtn extends StatefulWidget {
  final VoidCallback onTap;
  final AppColors colors;
  const _ContactBtn({required this.onTap, required this.colors});

  @override
  State<_ContactBtn> createState() => _ContactBtnState();
}

class _ContactBtnState extends State<_ContactBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.colors;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
          decoration: BoxDecoration(
            color: _hovered ? c.primaryDark : c.primary,
            borderRadius: BorderRadius.circular(8),
            boxShadow: _hovered
                ? [BoxShadow(color: c.shadowRed, blurRadius: 20, offset: const Offset(0, 6))]
                : [],
          ),
          child: Text(
            'Contact',
            style: GoogleFonts.dmSans(decoration: TextDecoration.none, 
              fontSize: 13.5, fontWeight: FontWeight.w600,
              color: Colors.white, letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}
