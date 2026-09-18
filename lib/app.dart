import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:openeval/core/theme/app_theme.dart';
import 'package:openeval/core/theme/board_themes/board_theme_provider.dart';
import 'package:openeval/core/theme/piece_sets/piece_set_provider.dart';
import 'package:openeval/features/game_importer/screens/game_importer_screen.dart';
import 'package:openeval/features/game_importer/controllers/game_importer_controller.dart';
import 'package:openeval/features/analysis/screens/analysis_screen.dart';
import 'package:openeval/features/analysis/controllers/analysis_controller.dart';
import 'package:openeval/features/bot_play/screens/bot_play_screen.dart';
import 'package:openeval/features/bot_play/controllers/bot_controller.dart';
import 'package:openeval/features/local_multiplayer/screens/local_mp_screen.dart';
import 'package:openeval/features/settings/controllers/settings_controller.dart';
import 'package:openeval/features/settings/screens/settings_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BoardThemeProvider()),
        ChangeNotifierProvider(create: (_) => PieceSetProvider()),
        ChangeNotifierProvider(create: (_) => SettingsController()),
        ChangeNotifierProvider(create: (_) => GameImporterController()),
        ChangeNotifierProvider(create: (_) => AnalysisController()),
        ChangeNotifierProvider(create: (_) => BotController()),
      ],
      child: MaterialApp(
        title: 'OpenEval',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: const MainScreen(),
        routes: {
          '/importer': (context) => const GameImporterScreen(),
          '/analysis': (context) => const AnalysisScreen(),
          '/bot': (context) => const BotPlayScreen(),
          '/local_mp': (context) => const LocalMultiplayerScreen(),
          '/settings': (context) => const SettingsScreen(),
        },
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'OpenEval',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1A73E8),
        foregroundColor: Colors.white,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        padding: const EdgeInsets.all(16),
        children: [
          _buildMenuCard(
            icon: Icons.import_export,
            title: 'Import Game',
            subtitle: 'Chess.com URLs',
            onTap: () => Navigator.pushNamed(context, '/importer'),
          ),
          _buildMenuCard(
            icon: Icons.assessment,
            title: 'Analyze',
            subtitle: 'Deep analysis engine',
            onTap: () => Navigator.pushNamed(context, '/analysis'),
          ),
          _buildMenuCard(
            icon: Icons.auto_awesome,
            title: 'Play vs Bot',
            subtitle: 'Adjustable Elo',
            onTap: () => Navigator.pushNamed(context, '/bot'),
          ),
          _buildMenuCard(
            icon: Icons.people,
            title: 'Local Multiplayer',
            subtitle: 'Pass & Play',
            onTap: () => Navigator.pushNamed(context, '/local_mp'),
          ),
          _buildMenuCard(
            icon: Icons.settings,
            title: 'Settings',
            subtitle: 'Themes & preferences',
            onTap: () => Navigator.pushNamed(context, '/settings'),
          ),
          _buildMenuCard(
            icon: Icons.library_books,
            title: 'Game Library',
            subtitle: 'Saved games',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: const Color(0xFF1A73E8)),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
