import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});
  @override
  Widget build(BuildContext context) {
    final c = AppTheme.of(context).colors;
    final isWide = MediaQuery.of(context).size.width > 900;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      color: c.bgAlt,
      child: Stack(
        children: [
          Positioned(bottom: 0, left: 0, right: 0,
            child: Container(height: 220,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter, end: Alignment.bottomCenter,
                  colors: [Colors.transparent, c.primaryXL.withOpacity(0.6)],
                )),
            )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isWide ? 80 : 28, vertical: 90),
            child: Column(children: [
              AnimatedReveal(child: _ContactHero(c)),
              const SizedBox(height: 60),
              AnimatedReveal(delay: const Duration(milliseconds: 200), child: _SocialGrid(c)),
              const SizedBox(height: 60),
              AnimatedReveal(delay: const Duration(milliseconds: 350), child: _Footer(c)),
            ]),
          ),
        ],
      ),
    );
  }
}

class _ContactHero extends StatelessWidget {
  final AppColors c;
  const _ContactHero(this.c);
  @override
  Widget build(BuildContext context) => Column(children: [
    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(width: 40, height: 2, color: c.primary),
      const SizedBox(width: 12),
      Text('GET IN TOUCH', style: GoogleFonts.dmSans(decoration: TextDecoration.none, 
        fontSize: 11.5, fontWeight: FontWeight.w700, letterSpacing: 3, color: c.primary)),
      const SizedBox(width: 12),
      Container(width: 40, height: 2, color: c.primary),
    ]),
    const SizedBox(height: 20),
    Text("Let's build\nsomething great.", textAlign: TextAlign.center,
      style: GoogleFonts.playfairDisplay(decoration: TextDecoration.none, 
        fontSize: 52, fontWeight: FontWeight.w700, color: c.text, height: 1.1,
        fontStyle: FontStyle.italic)),
    const SizedBox(height: 18),
    Text("I'm open to internships, collaborations & exciting projects.\nIf you have an idea that needs clean execution — let's talk.",
      textAlign: TextAlign.center,
      style: GoogleFonts.dmSans(decoration: TextDecoration.none, fontSize: 15, color: c.textSecondary, height: 1.75)),
    const SizedBox(height: 36),
    _EmailBtn(c),
  ]);
}

class _EmailBtn extends StatefulWidget {
  final AppColors c;
  const _EmailBtn(this.c);
  @override State<_EmailBtn> createState() => _EmailBtnState();
}
class _EmailBtnState extends State<_EmailBtn> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    final c = widget.c;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse('mailto:manthan.suthar.dev@gmail.com')),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
          transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
          decoration: BoxDecoration(
            color: _hovered ? c.primaryDark : c.primary,
            borderRadius: BorderRadius.circular(50),
            boxShadow: _hovered ? [BoxShadow(color: c.shadowRed, blurRadius: 36, offset: const Offset(0, 10))] : [],
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            const Text('✉️', style: TextStyle(decoration: TextDecoration.none, fontSize: 18)),
            const SizedBox(width: 10),
            Text('manthan.suthar.dev@gmail.com',
              style: GoogleFonts.dmSans(decoration: TextDecoration.none, fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
          ]),
        ),
      ),
    );
  }
}

class _SocialGrid extends StatelessWidget {
  final AppColors c;
  const _SocialGrid(this.c);
  @override
  Widget build(BuildContext context) => Wrap(
    alignment: WrapAlignment.center, spacing: 14, runSpacing: 14,
    children: [
      _SocialCard('🐙', 'GitHub',    '@1002manthan',                    'https://github.com/1002manthan', c),
      _SocialCard('💼', 'LinkedIn',  'Manthan Suthar',                  'https://www.linkedin.com/in/manthan-suthar-9138002a3', c),
      _SocialCard('📷', 'Instagram', '@youknowmanthan',                 'https://www.instagram.com/youknowmanthan/', c),
      _SocialCard('✉️', 'Email',     'manthan.suthar.dev@gmail.com',    'mailto:manthan.suthar.dev@gmail.com', c),
    ],
  );
}

class _SocialCard extends StatefulWidget {
  final String icon, label, sub, url; final AppColors c;
  const _SocialCard(this.icon, this.label, this.sub, this.url, this.c);
  @override State<_SocialCard> createState() => _SocialCardState();
}
class _SocialCardState extends State<_SocialCard> {
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
          duration: const Duration(milliseconds: 200),
          width: 200, padding: const EdgeInsets.all(20),
          transform: Matrix4.translationValues(0, _hovered ? -5 : 0, 0),
          decoration: BoxDecoration(
            color: _hovered ? c.primaryXL : c.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _hovered ? c.primaryLight : c.borderLight),
            boxShadow: [BoxShadow(
              color: _hovered ? c.shadowRed : c.shadow,
              blurRadius: _hovered ? 28 : 8, offset: const Offset(0, 4),
            )],
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(widget.icon, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 12),
            Text(widget.label, style: GoogleFonts.dmSans(decoration: TextDecoration.none, 
              fontSize: 14, fontWeight: FontWeight.w700,
              color: _hovered ? c.primary : c.text)),
            const SizedBox(height: 3),
            Text(widget.sub, style: GoogleFonts.dmSans(decoration: TextDecoration.none, fontSize: 11.5, color: c.textMuted),
              maxLines: 1, overflow: TextOverflow.ellipsis),
          ]),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final AppColors c;
  const _Footer(this.c);
  @override
  Widget build(BuildContext context) => Column(children: [
    Container(height: 1, color: c.borderLight),
    const SizedBox(height: 28),
    RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: GoogleFonts.dmSans(decoration: TextDecoration.none, fontSize: 13, color: c.textMuted),
        children: [
          const TextSpan(text: 'Crafted with '),
          TextSpan(text: '♥', style: GoogleFonts.dmSans(decoration: TextDecoration.none, fontSize: 14, color: c.primary)),
          const TextSpan(text: ' by '),
          TextSpan(text: 'Manthan Suthar',
            style: GoogleFonts.dmSans(decoration: TextDecoration.none, fontSize: 13, fontWeight: FontWeight.w600, color: c.text)),
          const TextSpan(text: '  ·  Flutter · 2024'),
        ],
      ),
    ),
  ]);
}
