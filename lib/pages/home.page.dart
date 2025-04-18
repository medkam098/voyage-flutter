import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:shared_preferences/shared_preferences.dart";
import "../theme/app_theme.dart";
import "../providers/theme_provider.dart";
import "../widgets/widgets.dart";

class Home extends StatelessWidget {
  static late SharedPreferences prefs;
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Accueil',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Welcome section (si vous en avez une)

          // Quick actions section
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 4),
            child: AppText.subheading('Actions rapides'),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildActionCard(
                  context,
                  Icons.explore,
                  'Explorer',
                  AppTheme.primaryColor,
                      () => Navigator.pushNamed(context, '/pays'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildActionCard(
                  context,
                  Icons.wb_sunny,
                  'Météo',
                  AppTheme.accentColor,
                      () => Navigator.pushNamed(context, '/meteo'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildActionCard(
                  context,
                  Icons.photo_library,
                  'Galerie',
                  AppTheme.secondaryColor,
                      () => Navigator.pushNamed(context, '/gallerie'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildActionCard(
                  context,
                  Icons.people,
                  'Amis',
                  AppTheme.accentColor,
                      () => Navigator.pushNamed(context, '/mates'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildActionCard(
                  context,
                  Icons.contact_mail,
                  'Contact',
                  AppTheme.primaryColor.withAlpha(180),
                      () => Navigator.pushNamed(context, '/contact'),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(child: SizedBox()), // Placeholder pour équilibrer la grille
            ],
          ),

          // Logout button
          const SizedBox(height: 36),
          AppButton(
            text: 'Déconnexion',
            icon: Icons.logout,
            isPrimary: false,
            onPressed: () => _onDeconnecter(context),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
      BuildContext context,
      IconData icon,
      String title,
      Color color,
      VoidCallback onTap,
      ) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = themeProvider.isDarkMode;

    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isDarkMode ? AppTheme.primaryColor : color,
            size: 34,
          ),
          const SizedBox(height: 14),
          AppText.body(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> _onDeconnecter(BuildContext context) async {
    final navigator = Navigator.of(context);
    prefs = await SharedPreferences.getInstance();
    prefs.setBool("connecte", false);
    navigator.pushNamedAndRemoveUntil('/inscription', (route) => false);
  }
}