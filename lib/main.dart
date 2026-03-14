import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme/app_theme.dart';
import 'portfolio_page.dart';

void main() => runApp(const ManthanPortfolio());

class ManthanPortfolio extends StatefulWidget {
  const ManthanPortfolio({super.key});
  @override
  State<ManthanPortfolio> createState() => _ManthanPortfolioState();
}

class _ManthanPortfolioState extends State<ManthanPortfolio> {
  bool _isDark = false;
  void _toggleTheme() => setState(() => _isDark = !_isDark);

  @override
  Widget build(BuildContext context) {
    final colors = AppColors(_isDark);
    return MaterialApp(
      title: 'Manthan Suthar — Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: _isDark ? Brightness.dark : Brightness.light,
        scaffoldBackgroundColor: colors.bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE8173A),
          brightness: _isDark ? Brightness.dark : Brightness.light,
        ),
        textTheme: GoogleFonts.dmSansTextTheme(
          _isDark ? ThemeData.dark().textTheme : ThemeData.light().textTheme,
        ).apply(
          // ── Kill ALL underlines globally ──
          decoration: TextDecoration.none,
          bodyColor: colors.text,
          displayColor: colors.text,
        ),
      ),
      home: AppTheme(
        colors: colors,
        onToggle: _toggleTheme,
        child: const PortfolioPage(),
      ),
    );
  }
}
