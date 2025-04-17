import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';
import '../widgets/widgets.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Drawer(
      backgroundColor: AppTheme.backgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50, bottom: 16),
            decoration: BoxDecoration(
              color:
                  isDarkMode
                      ? AppTheme.secondaryColorLight
                      : AppTheme.primaryColorLight,
              border: Border(
                bottom: BorderSide(
                  color:
                      isDarkMode
                          ? AppTheme.dividerColor
                          : AppTheme.primaryColor.withAlpha(40),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDarkMode ? AppTheme.primaryColor : Colors.white,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isDarkMode 
                            ? Colors.black26
                            : AppTheme.shadowColor,
                        blurRadius: isDarkMode ? 6 : 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundImage: const AssetImage("images/profil.jpg"),
                    radius: 50,
                    backgroundColor: isDarkMode 
                        ? AppTheme.surfaceColor 
                        : Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                AppText.heading(
                  "Voyage",
                  style: TextStyle(
                    color: isDarkMode 
                        ? AppTheme.textColor 
                        : Colors.white,
                    fontWeight: AppTheme.boldWeight,
                  ),
                ),
                const SizedBox(height: 4),
                AppText.caption(
                  "Explorez le monde",
                  style: TextStyle(
                    color: isDarkMode 
                        ? AppTheme.textColor.withOpacity(0.8)
                        : Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _buildMenuItem(
            context: context,
            title: "Accueil",
            icon: Icons.home,
            route: '/home',
            isDarkMode: isDarkMode,
          ),
          _buildMenuItem(
            context: context,
            title: "Amis",
            icon: Icons.people,
            route: '/mates',
            isDarkMode: isDarkMode,
          ),
          _buildMenuItem(
            context: context,
            title: "Galerie",
            icon: Icons.photo_library,
            route: '/gallerie',
            isDarkMode: isDarkMode,
          ),
          _buildMenuItem(
            context: context,
            title: "Pays",
            icon: Icons.flag,
            route: '/pays',
            isDarkMode: isDarkMode,
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(),
          ),

          _buildMenuItem(
            context: context,
            title: "Contact",
            icon: Icons.contact_mail,
            route: '/contact',
            isDarkMode: isDarkMode,
          ),
          _buildMenuItem(
            context: context,
            title: "Paramètres",
            icon: Icons.settings,
            route: '/parametres',
            isDarkMode: isDarkMode,
          ),

          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppButton(
              text: "Déconnexion",
              icon: Icons.logout,
              isPrimary: false,
              padding: const EdgeInsets.symmetric(vertical: 12),
              onPressed: () async {
                // Get the navigator before the async gap
                final navigator = Navigator.of(context);
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool("connecte", false);
                navigator.pushNamedAndRemoveUntil(
                  '/inscription',
                  (route) => false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    required String route,
    required bool isDarkMode,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: AppListTile(
        title: title,
        leadingIcon: icon,
        trailingIcon: Icons.arrow_forward_ios,
        hasDivider: false,
        onTap: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}
