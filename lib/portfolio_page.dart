import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'widgets/nav_bar.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/projects_section.dart';
import 'sections/experience_section.dart';
import 'sections/education_section.dart';
import 'sections/contact_section.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});
  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scrollController = ScrollController();
  final _heroKey       = GlobalKey();
  final _aboutKey      = GlobalKey();
  final _skillsKey     = GlobalKey();
  final _projectsKey   = GlobalKey();
  final _experienceKey = GlobalKey();
  final _educationKey  = GlobalKey();
  final _contactKey    = GlobalKey();
  bool _isScrolled = false;
  double _smoothTarget = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final scrolled = _scrollController.offset > 50;
      if (scrolled != _isScrolled) setState(() => _isScrolled = scrolled);
    });
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      _smoothTarget = _scrollController.offset;
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeInOutCubic,
        alignment: 0.0,
      );
    }
  }

  void _onPointerScroll(PointerScrollEvent event) {
    if (!_scrollController.hasClients) return;
    final pos = _scrollController.position;
    _smoothTarget = (_smoothTarget + event.scrollDelta.dy * 1.1)
        .clamp(pos.minScrollExtent, pos.maxScrollExtent);
    _scrollController.animateTo(
      _smoothTarget,
      duration: const Duration(milliseconds: 550),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() { _scrollController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final c = AppTheme.of(context).colors;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      color: c.bg,
      child: DefaultTextStyle(
        // ── Kill ALL inherited underlines on Flutter web ──
        style: TextStyle(decoration: TextDecoration.none,
          color: c.text,
          fontFamily: 'DM Sans',
        ),
        child: Listener(
        onPointerSignal: (event) {
          if (event is PointerScrollEvent) _onPointerScroll(event);
        },
        child: ScrollConfiguration(
          behavior: SmoothScrollBehavior(),
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 72),
                    HeroSection(key: _heroKey),
                    AboutSection(key: _aboutKey),
                    SkillsSection(key: _skillsKey),
                    ProjectsSection(key: _projectsKey),
                    ExperienceSection(key: _experienceKey),
                    EducationSection(key: _educationKey),
                    ContactSection(key: _contactKey),
                  ],
                ),
              ),
              Positioned(
                top: 0, left: 0, right: 0,
                child: NavBar(
                  isScrolled: _isScrolled,
                  onTap: (section) {
                    switch (section) {
                      case 'about':      _scrollTo(_aboutKey);
                      case 'skills':     _scrollTo(_skillsKey);
                      case 'projects':   _scrollTo(_projectsKey);
                      case 'experience': _scrollTo(_experienceKey);
                      case 'education':  _scrollTo(_educationKey);
                      case 'contact':    _scrollTo(_contactKey);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        ),  // Listener
      ),    // DefaultTextStyle
    );
  }
}
