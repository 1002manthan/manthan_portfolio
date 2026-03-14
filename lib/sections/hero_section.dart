import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../widgets/orbit_widget.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});
  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _fade  = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    Future.delayed(const Duration(milliseconds: 150), () { if (mounted) _ctrl.forward(); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final c = AppTheme.of(context).colors;
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 900;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      width: double.infinity,
      constraints: BoxConstraints(minHeight: size.height - 72),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: c.heroBg,
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _DotGridPainter(c.dotColor))),
          Positioned(top: -100, right: -80, child: _Blob(420, c.primaryLight.withOpacity(0.35))),
          Positioned(bottom: 60, left: -70, child: _Blob(280, c.primaryXL)),
          Positioned(top: 180, right: 260, child: _Blob(90, c.primaryLight.withOpacity(0.6))),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isWide ? 80 : 28, vertical: 70),
              child: FadeTransition(
                opacity: _fade,
                child: SlideTransition(
                  position: _slide,
                  child: isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(flex: 6, child: _HeroText(c)),
                            const SizedBox(width: 60),
                            Expanded(flex: 4, child: Center(child: OrbitWidget())),
                          ],
                        )
                      : _HeroText(c),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30, left: 0, right: 0,
            child: FadeTransition(
              opacity: _fade,
              child: Column(
                children: [
                  Text('SCROLL', style: GoogleFonts.dmSans(decoration: TextDecoration.none, 
                    fontSize: 10, letterSpacing: 3,
                    color: c.textMuted, fontWeight: FontWeight.w500,
                  )),
                  const SizedBox(height: 8),
                  _ScrollIndicator(c),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroText extends StatelessWidget {
  final AppColors c;
  const _HeroText(this.c);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Available badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: c.primaryXL,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: c.primaryLight),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _PulseDot(c),
              const SizedBox(width: 8),
              Text('Available for opportunities',
                style: GoogleFonts.dmSans(decoration: TextDecoration.none, fontSize: 12.5, fontWeight: FontWeight.w600, color: c.primary)),
            ],
          ),
        ),
        const SizedBox(height: 28),
        RichText(
          text: TextSpan(children: [
            TextSpan(text: 'Manthan\n', style: GoogleFonts.playfairDisplay(decoration: TextDecoration.none, 
              fontSize: 74, fontWeight: FontWeight.w700, color: c.text, height: 1.0)),
            TextSpan(text: 'Suthar.', style: GoogleFonts.playfairDisplay(decoration: TextDecoration.none, 
              fontSize: 74, fontWeight: FontWeight.w700, color: c.primary, height: 1.05,
              fontStyle: FontStyle.italic)),
          ]),
        ),
        const SizedBox(height: 22),
        Row(
          children: [
            Text('I build ', style: GoogleFonts.dmSans(decoration: TextDecoration.none, 
              fontSize: 19, color: c.textSecondary, fontWeight: FontWeight.w300)),
            AnimatedTextKit(
              repeatForever: true,
              pause: const Duration(milliseconds: 1200),
              animatedTexts: [
                TypewriterAnimatedText('beautiful apps.',
                  textStyle: GoogleFonts.dmSans(decoration: TextDecoration.none, fontSize: 19, fontWeight: FontWeight.w700, color: c.primary),
                  speed: const Duration(milliseconds: 70)),
                TypewriterAnimatedText('clean UIs.',
                  textStyle: GoogleFonts.dmSans(decoration: TextDecoration.none, fontSize: 19, fontWeight: FontWeight.w700, color: c.primary),
                  speed: const Duration(milliseconds: 70)),
                TypewriterAnimatedText('sharp experiences.',
                  textStyle: GoogleFonts.dmSans(decoration: TextDecoration.none, fontSize: 19, fontWeight: FontWeight.w700, color: c.primary),
                  speed: const Duration(milliseconds: 70)),
                TypewriterAnimatedText('things that matter.',
                  textStyle: GoogleFonts.dmSans(decoration: TextDecoration.none, fontSize: 19, fontWeight: FontWeight.w700, color: c.primary),
                  speed: const Duration(milliseconds: 70)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text('Flutter Developer · UI/UX Designer · CS Student from Ahmedabad',
          style: GoogleFonts.dmSans(decoration: TextDecoration.none, fontSize: 14, color: c.textMuted, height: 1.6)),
        const SizedBox(height: 36),
        Wrap(
          spacing: 14, runSpacing: 12,
          children: [
            _HeroBtn(label: 'View Projects', filled: true, c: c, onTap: () => launchUrl(Uri.parse('https://github.com/1002manthan'))),
            _HeroBtn(
              label: 'Get In Touch', filled: false, c: c,
              onTap: () => launchUrl(Uri.parse('mailto:manthan.suthar.dev@gmail.com')),
            ),
          ],
        ),
      ],
    );
  }
}


class _FloatingBadge extends StatelessWidget {
  final String label, icon;
  final Color bgColor;
  final AppColors c;
  const _FloatingBadge(this.label, this.icon, this.bgColor, this.c);

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
    decoration: BoxDecoration(
      color: bgColor, borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: c.shadow, blurRadius: 16, offset: const Offset(0, 4))],
      border: Border.all(color: c.borderLight),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Text(icon, style: const TextStyle(fontSize: 14)),
      const SizedBox(width: 6),
      Text(label, style: GoogleFonts.dmSans(decoration: TextDecoration.none, fontSize: 12, fontWeight: FontWeight.w600, color: c.text)),
    ]),
  );
}

class _HeroBtn extends StatefulWidget {
  final String label; final bool filled; final AppColors c; final VoidCallback onTap;
  const _HeroBtn({required this.label, required this.filled, required this.c, required this.onTap});
  @override State<_HeroBtn> createState() => _HeroBtnState();
}
class _HeroBtnState extends State<_HeroBtn> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    final c = widget.c;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
          decoration: BoxDecoration(
            color: widget.filled ? (_hovered ? c.primaryDark : c.primary) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: widget.filled ? null : Border.all(color: _hovered ? c.primary : c.border, width: 1.5),
            boxShadow: widget.filled && _hovered
                ? [BoxShadow(color: c.shadowRed, blurRadius: 28, offset: const Offset(0, 8))] : [],
          ),
          child: Text(widget.label, style: GoogleFonts.dmSans(decoration: TextDecoration.none, 
            fontSize: 14.5, fontWeight: FontWeight.w600, letterSpacing: 0.3,
            color: widget.filled ? Colors.white : (_hovered ? c.primary : c.text),
          )),
        ),
      ),
    );
  }
}

class _SocialChip extends StatefulWidget {
  final String icon, label, url;
  final AppColors c;
  const _SocialChip(this.icon, this.label, this.url, this.c);
  @override State<_SocialChip> createState() => _SocialChipState();
}
class _SocialChipState extends State<_SocialChip> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    final c = widget.c;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _hovered ? c.primaryXL : c.surfaceAlt,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _hovered ? c.primaryLight : c.border),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Text(widget.icon, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 6),
            Text(widget.label, style: GoogleFonts.dmSans(decoration: TextDecoration.none, 
              fontSize: 12.5, fontWeight: FontWeight.w500,
              color: _hovered ? c.primary : c.textSecondary,
            )),
          ]),
        ),
      ),
    );
  }
}

class _PulseDot extends StatefulWidget {
  final AppColors c;
  const _PulseDot(this.c);
  @override State<_PulseDot> createState() => _PulseDotState();
}
class _PulseDotState extends State<_PulseDot> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))
      ..repeat(reverse: true);
  }
  @override void dispose() { _ctrl.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => FadeTransition(
    opacity: Tween<double>(begin: 0.5, end: 1.0).animate(_ctrl),
    child: Container(width: 8, height: 8,
      decoration: BoxDecoration(color: widget.c.primary, shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: widget.c.shadowRed, blurRadius: 8)])),
  );
}

class _ScrollIndicator extends StatefulWidget {
  final AppColors c;
  const _ScrollIndicator(this.c);
  @override State<_ScrollIndicator> createState() => _ScrollIndicatorState();
}
class _ScrollIndicatorState extends State<_ScrollIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..repeat();
  }
  @override void dispose() { _ctrl.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    final c = widget.c;
    return Container(
      width: 22, height: 34,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: c.border, width: 1.5),
        borderRadius: BorderRadius.circular(11),
      ),
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, __) => Align(
          alignment: Alignment(0, _ctrl.value * 2 - 0.8),
          child: Container(width: 4, height: 4,
            decoration: BoxDecoration(color: c.primary, shape: BoxShape.circle)),
        ),
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  final double size;
  final Color color;
  const _Blob(this.size, this.color);
  @override
  Widget build(BuildContext context) => Container(
    width: size, height: size,
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
  );
}

class _DotGridPainter extends CustomPainter {
  final Color color;
  const _DotGridPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    const spacing = 32.0;
    for (double x = 0; x < size.width; x += spacing)
      for (double y = 0; y < size.height; y += spacing)
        canvas.drawCircle(Offset(x, y), 1.5, paint);
  }
  @override bool shouldRepaint(_) => true;
}
